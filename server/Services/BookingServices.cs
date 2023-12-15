using System;
using System.Net;
using Cooking_School.Dtos;
using Microsoft.EntityFrameworkCore;
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


            var bookings = await _redHouseDbContext.Bookings.Where(o => o.UserId == bookingDto.UserId
                                                                                && o.PropertyId == bookingDto.PropertyId).ToArrayAsync();
            var searchedBooking = bookings.FirstOrDefault();
            if (searchedBooking != null)
            {
                return new ResponsDto<Booking>
                {
                    Exception = new Exception("You can't create more than one book to the same property"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            Booking booking = new Booking
            {
                UserId = bookingDto.UserId,
                PropertyId = bookingDto.PropertyId
            };


            var bookingRes = await _redHouseDbContext.Bookings.AddAsync(booking);
            _redHouseDbContext.SaveChanges();


            foreach (var day in bookingDto.BookingDays)
            {
                BookingDay bookingDay = new BookingDay
                {
                    BookingId = bookingRes.Entity.Id,
                    DayDate = day
                };
                await _redHouseDbContext.BookingDays.AddAsync(bookingDay);
                _redHouseDbContext.SaveChanges();
            }

            return new ResponsDto<Booking>
            {
                Dto = bookingRes.Entity,
                Message = "Booking Done Successfully",
                StatusCode = HttpStatusCode.OK,
            };
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

            var bookings = await _redHouseDbContext.Bookings.Where(b => b.UserId == userId).Include(b => b.Property).ToArrayAsync();

            return new ResponsDto<Booking>
            {
                ListDto = bookings,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<BookingDay>> GetAvilableBookingDaysForProperty(int propertyId)
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

            var booking =  _redHouseDbContext.Bookings.FirstOrDefault(b => b.PropertyId == propertyId);
            var bookingDays = await _redHouseDbContext.BookingDays.Where(b => b.BookingId == booking.Id).ToArrayAsync();

            return new ResponsDto<BookingDay>
            {
                ListDto = bookingDays,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public Task<ResponsDto<Booking>> GetBooking(int bookingId)
        {
            throw new NotImplementedException();
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
