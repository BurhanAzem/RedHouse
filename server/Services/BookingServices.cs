using System;
using System.Net;
using Cooking_School.Dtos;
using Hangfire;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client.Extensibility;
using Microsoft.IdentityModel.Tokens;
using RedHouse_Server.Dtos.ApplicationDtos;
using RedHouse_Server.Dtos.ContractDtos;
using RedHouse_Server.Dtos.OfferDtos;
using RedHouse_Server.Models;
using server.Models;

namespace server.Services
{
    public class BookingServices : IBookingServices
    {
        private RedHouseDbContext _redHouseDbContext;
        public BookingServices(RedHouseDbContext redHouseDbContext)
        {
            _redHouseDbContext = redHouseDbContext;
        }

        public Task<ResponsDto<Booking>> AcceptBooking(int offerId)
        {
            throw new NotImplementedException();
        }

        public async Task<ResponsDto<Contract>> AcceptOffer(int offerId)
        {
            var offer = await _redHouseDbContext.Offers.FindAsync(offerId);
            if (offer == null)
            {
                return new ResponsDto<Contract>
                {
                    Exception = new Exception("Offer Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            offer.OfferStatus = "Accepted";
            var property = await _redHouseDbContext.Properties.FindAsync(offer.PropertyId);

            _redHouseDbContext.Offers.Update(offer);
            _redHouseDbContext.SaveChanges();
            Contract contract = new Contract
            {
                OfferId = offer.Id,
                ContractStatus = "Active",
                ContractType = property.ListingType,
                Earnings = 0,
                IsShouldPay = 1,
                StartDate = DateTime.Now,
            };

            var contractRes = await _redHouseDbContext.Contracts.AddAsync(contract);
            _redHouseDbContext.SaveChanges();

            Milestone milestone = new Milestone
            {
                ContractId = contractRes.Entity.Id,
                Description = contract.Offer.Description,
                Amount = contract.Offer.Price,
                MilestoneDate = contract.StartDate,
                MilestoneName = contract.ContractType == "For rent" ? "Monthly Bills" : "Total Price",
                MilestoneStatus = "Pending"
            };


            var milestoneRes = await _redHouseDbContext.Milestones.AddAsync(milestone);
            _redHouseDbContext.SaveChanges();

            return new ResponsDto<Contract>
            {
                Dto = contractRes.Entity,
                StatusCode = HttpStatusCode.OK,
            };
        }


        public async Task<ResponsDto<Booking>> Book(BookingDto bookingDto)
        {
            var user = await _redHouseDbContext.Users.FindAsync(bookingDto.UserId);
            if (user == null)
            {
                return new ResponsDto<Booking>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            var property = await _redHouseDbContext.Properties.FindAsync(bookingDto.PropertyId);


            // var bookings = await _redHouseDbContext.Bookings.Where(o => o.UserId == bookingDto.UserId
            //                                                                     && o.PropertyId == bookingDto.PropertyId).ToArrayAsync();
            // var searchedBooking = bookings.FirstOrDefault();
            // if (searchedBooking != null)
            // {
            //     return new ResponsDto<Booking>
            //     {
            //         Exception = new Exception("You can't create more than one book to the same property"),
            //         StatusCode = HttpStatusCode.BadRequest,
            //     };
            // }
            DateTime dateNow = DateTime.Now;
            dateNow = dateNow.AddMinutes(-dateNow.Minute);
            dateNow = dateNow.AddHours(-dateNow.Hour);
            Console.WriteLine(dateNow);

            // Now 'modifiedDate' has the same date and time as 'dateNow', but with minutes set to 00


            var thirtyDaysAfter = dateNow.AddDays(30);


            foreach (var date in bookingDto.BookingDays)
            {
                if (date < dateNow || date > thirtyDaysAfter)
                    return new ResponsDto<Booking>
                    {
                        Exception = new Exception("You are trying booking not available day #"),
                        StatusCode = HttpStatusCode.BadRequest,
                    };

                var bookingDay = await _redHouseDbContext.BookingDays.Where(b => b.DayDate.Day == date.Day
                                                                              && b.DayDate.Month == date.Month
                                                                              && b.DayDate.Year == date.Year
                                                                              && b.Booking.PropertyId == bookingDto.PropertyId
                                                                              && b.Booking.BookingStatus != "Done").FirstOrDefaultAsync();
                if (bookingDay != null)
                    return new ResponsDto<Booking>
                    {
                        Exception = new Exception("You are trying booking not available day *"),
                        StatusCode = HttpStatusCode.BadRequest,
                    };
                _redHouseDbContext.SaveChanges();
            }


            Random random = new Random();
            // Generate two random 5-digit numbers and concatenate them to form a 10-digit number
            int firstPart = random.Next(10000, 99999);
            int secondPart = random.Next(10000, 99999);
            int thirdPart = random.Next(10000, 99999);
            string random_number_str = $"{firstPart:D5}{secondPart:D5}{thirdPart:D5}";

            Booking booking = new Booking
            {
                UserId = bookingDto.UserId,
                PropertyId = bookingDto.PropertyId,
                BookingCode = random_number_str,
                BookingStatus = "InProcess"
            };


            var bookingRes = await _redHouseDbContext.Bookings.AddAsync(booking);
            _redHouseDbContext.SaveChanges();

            List<DateTime> EndingOfBookingDayIntervals = new List<DateTime>();

            for (int i = 0; i < bookingDto.BookingDays.Count; i++)
            {
                BookingDay bookingDay = new BookingDay
                {
                    BookingId = bookingRes.Entity.Id,
                    DayDate = bookingDto.BookingDays[i]
                };
                await _redHouseDbContext.BookingDays.AddAsync(bookingDay);
                _redHouseDbContext.SaveChanges();
            }

            if (!bookingDto.BookingDays.IsNullOrEmpty())
            {
                if (bookingDto.BookingDays.Count == 1)
                {
                    var jobId = $"RecurringJob_{bookingDto.BookingDays[0]}";

                    // Assuming bookingDto.BookingDays[0] contains the exact DateTime you want the job to run
                    var cronExpression = $"{59} {11} {bookingDto.BookingDays[0].Day} {bookingDto.BookingDays[0].Month} ?";

                    // Remove the existing recurring job if it exists
                    RecurringJob.RemoveIfExists(jobId);

                    // Schedule the new recurring job
                    RecurringJob.AddOrUpdate(jobId, () => EndBookingProcess(bookingRes.Entity.Id), cronExpression);
                }
                for (int i = 0; i < bookingDto.BookingDays.Count - 1; i++)
                {
                    if (i + 1 == bookingDto.BookingDays.Count - 1)
                    {
                        ScheduleRecurringJob(bookingDto.BookingDays[i + 1], "11:59", EndBookingProcess); // Pause
                    }
                    else if ((bookingDto.BookingDays[i + 1].Day - bookingDto.BookingDays[i].Day) > 1)
                    {
                        ScheduleRecurringJob(bookingDto.BookingDays[i + 1], "11:59", ResumeBookingProcess); // Resume
                        ScheduleRecurringJob(bookingDto.BookingDays[i], "12:01", PauseBookingProcess); // Pause
                    }
                }
                async Task ScheduleRecurringJob(DateTime date, string time, Func<int, Task> myAsyncAction)
                {
                    var jobId = $"RecurringJob_{date}";

                    var cronExpression = $"{time.Split(':')[1]} {time.Split(':')[0]} {date.Day} {date.Month} ?";

                    RecurringJob.RemoveIfExists(jobId);

                    RecurringJob.AddOrUpdate(jobId, () => myAsyncAction(bookingRes.Entity.Id), cronExpression);
                }


            }


            // Rest of your code


            // Rest of your code

            return new ResponsDto<Booking>
            {
                Dto = bookingRes.Entity,
                Message = "Booking Done Successfully",
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task EndBookingProcess(int bookingId)
        {
            // Your asynchronous code here
            var bookings = await _redHouseDbContext.Bookings
                .Where(b => b.Id == bookingId).ToListAsync();
            var booking = bookings.FirstOrDefault();
            if (booking != null)
            {
                booking.BookingStatus = "Done";
                _redHouseDbContext.Bookings.Update(booking);
                _redHouseDbContext.SaveChanges();
            }

            // Do something with 'booking' if needed
        }

        public async Task PauseBookingProcess(int bookingId)
        {
            // Your asynchronous code here
            var bookings = await _redHouseDbContext.Bookings
                .Where(b => b.Id == bookingId).ToListAsync();
            var booking = bookings.FirstOrDefault();
            if (booking != null)
            {
                booking.BookingStatus = "Pause";
                _redHouseDbContext.Bookings.Update(booking);
                _redHouseDbContext.SaveChanges();
            }

            // Do something with 'booking' if needed
        }
        public async Task ResumeBookingProcess(int bookingId)
        {
            // Your asynchronous code here
            var bookings = await _redHouseDbContext.Bookings
                .Where(b => b.Id == bookingId).ToListAsync();
            var booking = bookings.FirstOrDefault();
            if (booking != null)
            {
                booking.BookingStatus = "InProcess";
                _redHouseDbContext.Bookings.Update(booking);
                _redHouseDbContext.SaveChanges();
            }

            // Do something with 'booking' if needed
        }




        public async Task<ResponsDto<Booking>> DeleteBooking(int bookingId)
        {
            var booking = await _redHouseDbContext.Bookings.FindAsync(bookingId);
            if (booking == null)
            {
                return new ResponsDto<Booking>
                {
                    Exception = new Exception("Book Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }


            _redHouseDbContext.Bookings.Remove(booking);
            _redHouseDbContext.SaveChanges();

            return new ResponsDto<Booking>
            {
                Message = "Book Deleted Successfully",
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Booking>> GetAllBookings()
        {


            var bookings = await _redHouseDbContext.Bookings.Include(b => b.Property).ToArrayAsync();

            return new ResponsDto<Booking>
            {
                ListDto = bookings,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Booking>> GetAllBookingsForUser(int userId)
        {
            var user = await _redHouseDbContext.Users.FindAsync(userId);
            if (user == null)
            {
                return new ResponsDto<Booking>
                {
                    Exception = new Exception($"User with {userId} Id Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            var bookings = await _redHouseDbContext.Bookings.Where(b => b.UserId == userId).Include(b => b.Property).Include(b => b.BookingDays).ToArrayAsync();

            return new ResponsDto<Booking>
            {
                ListDto = bookings,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<BookingDay>> GetBookingDaysForProperty(int propertyId)
        {
            var property = await _redHouseDbContext.Properties.FindAsync(propertyId);
            if (property == null)
            {
                return new ResponsDto<BookingDay>
                {
                    Exception = new Exception($"Property with {propertyId} Id Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            // var booking = _redHouseDbContext.Bookings.FirstOrDefault(b => b.PropertyId == propertyId);
            List<BookingDay> bookingDays = new List<BookingDay>();
            // if (booking != null)
            // {
                var thirtyDaysAgo = DateTime.Now;
                var thirtyDaysAfter = DateTime.Now.AddDays(30);

                bookingDays = await _redHouseDbContext.BookingDays
                   .Where(b => b.Booking.PropertyId == propertyId && b.Booking.BookingStatus != "Done")
                   .ToListAsync();

                // Rest of your code
            // }

            return new ResponsDto<BookingDay>
            {
                ListDto = bookingDays,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Booking>> GetBooking(int bookingId)
        {
            var booking = await _redHouseDbContext.Bookings.Where(b => b.Id == bookingId).Include(b => b.User).Include(b => b.Property).Include(b => b.BookingDays).FirstOrDefaultAsync();
            if (booking == null)
            {
                return new ResponsDto<Booking>
                {
                    Exception = new Exception("Booking Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            return new ResponsDto<Booking>
            {
                Dto = booking,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Offer>> GetOffer(int offerId)
        {
            var offer = await _redHouseDbContext.Offers.FindAsync(offerId);
            if (offer == null)
            {
                return new ResponsDto<Offer>
                {
                    Exception = new Exception("Offer Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            return new ResponsDto<Offer>
            {
                Dto = offer,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<int> NumberOfBookings()
        {
            return await _redHouseDbContext.Bookings.CountAsync();
        }





        public async Task<ResponsDto<Booking>> UpdateBooking(BookingDto bookingDto, int bookingId)
        {
            var booking = await _redHouseDbContext.Bookings
                 .FirstOrDefaultAsync(c => c.Id == bookingId);
            if (booking == null)
            {
                return new ResponsDto<Booking>
                {
                    Exception = new Exception("Booking Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            Booking updatedBooking = new Booking
            {
                PropertyId = bookingDto.PropertyId,
                UserId = bookingDto.UserId

            };
            _redHouseDbContext.Bookings.Update(updatedBooking);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Booking>
            {
                Dto = updatedBooking,
                Message = "Booking updated successfully",
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}
