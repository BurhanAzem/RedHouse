using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;
using System.Net;
using server.Dtos.PropertyDtos;
using Microsoft.EntityFrameworkCore;
using server.Models;

namespace RedHouse_Server.Services
{
    public class PropertyServices : IPropertyServices
    {
        private RedHouseDbContext _redHouseDbContext;
        public PropertyServices(RedHouseDbContext blueHouseDbContext)
        {
            _redHouseDbContext = blueHouseDbContext;
        }
        public async Task<ResponsDto<Property>> AddProperty(PropertyDto propertyDto)
        {
            var user = await _redHouseDbContext.Users.FindAsync(propertyDto.UserId);
            if (user == null)
            {
                return new ResponsDto<Property>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            Location location = new Location
            {
                City = propertyDto.LocationDto.City,
                Country = propertyDto.LocationDto.Country,
                Region = propertyDto.LocationDto.Region,
                PostalCode = propertyDto.LocationDto.PostalCode,
                StreetAddress = propertyDto.LocationDto.StreetAddress,
                Latitude = propertyDto.LocationDto.Latitude,
                Longitude = propertyDto.LocationDto.Longitude,
            };
            var locationRes = await _redHouseDbContext.Locations.AddAsync(location);
            await _redHouseDbContext.SaveChangesAsync();

            Random random = new Random();
            // Generate two random 5-digit numbers and concatenate them to form a 10-digit number
            int firstPart = random.Next(10000, 99999);
            int secondPart = random.Next(10000, 99999);
            string random_number_str = $"{firstPart:D5}{secondPart:D5}";

            Property property = new Property
            {
                AvailableOn = propertyDto.AvailableOn,
                BuiltYear = propertyDto.BuiltYear,
                IsAvailableBasement = propertyDto.IsAvailableBasement,
                ListingBy = propertyDto.ListingBy,
                ListingType = propertyDto.ListingType,
                LocationId = locationRes.Entity.Id,
                PropertyCode = random_number_str,
                // NeighborhoodId = 0,
                NumberOfBathRooms = propertyDto.NumberOfBathRooms,
                NumberOfBedRooms = propertyDto.NumberOfBedRooms,
                NumberOfUnits = propertyDto.NumberOfUnits,
                ParkingSpots = propertyDto.ParkingSpots,
                Price = propertyDto.Price,
                PropertyDescription = propertyDto.PropertyDescription,
                PropertyStatus = propertyDto.PropertyStatus,
                PropertyType = propertyDto.PropertyType,
                SquareMetersArea = propertyDto.SquareMeter,
                UserId = propertyDto.UserId,
                View = propertyDto.View,
            };
            var propertyRes = await _redHouseDbContext.Properties.AddAsync(property);
            await _redHouseDbContext.SaveChangesAsync();
            int propertyId = propertyRes.Entity.Id;
            foreach (var file in propertyDto.PropertyFiles)
            {
                PropertyFile propertyFile = new PropertyFile
                {
                    PropertyId = propertyId,
                    DownloadUrls = file
                };
                await _redHouseDbContext.PropertyFiles.AddAsync(propertyFile);
                await _redHouseDbContext.SaveChangesAsync();
            }
            return new ResponsDto<Property>
            {
                Dto = propertyRes.Entity,
                Message = "Proprety Added Successfully",
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Property>> DeleteProperty(int propertyId)
        {
            var property = await _redHouseDbContext.Properties.FindAsync(propertyId);
            if (property == null)
            {
                return new ResponsDto<Property>
                {
                    Exception = new Exception($"Property with {propertyId} Dose Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            _redHouseDbContext.Properties.Remove(property);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Property>
            {
                Exception = new Exception($"Property with {propertyId} Deleted succussfuly"),
                StatusCode = HttpStatusCode.OK,
            };
        }


        public async Task<ResponsDto<Property>> GetProperties(FilterDto filterDto)
        {
            // Create a queryable variable based on the DbSet
            var query = _redHouseDbContext.Properties.AsQueryable();

            query = query.Where(p => p.Id >= 0);
            query = _redHouseDbContext.Properties
                                .Include(p => p.propertyFiles).Include(p => p.User);
            // Apply filtering based on the filterDto, if provided

            if (!string.IsNullOrEmpty(filterDto.MinPrice))
            {
                int minPrice;

                if (int.TryParse(filterDto.MinPrice, out minPrice))
                {
                    query = query.Where(p => p.Price >= minPrice);
                }
            }

            if (!string.IsNullOrEmpty(filterDto.MaxPrice))
            {
                int maxPrice;

                if (int.TryParse(filterDto.MaxPrice, out maxPrice))
                {
                    query = query.Where(p => p.Price <= maxPrice);
                }
            }

            if (!string.IsNullOrEmpty(filterDto.NumberOfBedRooms))
            {
                if (int.TryParse(filterDto.NumberOfBedRooms, out int numberOfBedRooms))
                {
                    query = query.Where(p => p.NumberOfBedRooms == numberOfBedRooms);
                }
            }

            if (!string.IsNullOrEmpty(filterDto.NumberOfBathRooms))
            {
                if (int.TryParse(filterDto.NumberOfBathRooms, out int numberOfBathRooms))
                {
                    query = query.Where(p => p.NumberOfBathRooms == numberOfBathRooms);
                }
            }

            if (!string.IsNullOrEmpty(filterDto.View))
            {
                query = query.Where(p => p.View == filterDto.View);
            }

            if (!string.IsNullOrEmpty(filterDto.ListingType))
            {
                query = query.Where(p => p.ListingType.Equals(filterDto.ListingType));
            }
            if (filterDto.PropertyTypes[0] == "[]") filterDto.PropertyTypes = null;

            if (filterDto.PropertyTypes != null)
            {
                foreach (var propertyType in filterDto.PropertyTypes)
                {
                    query = query.Where(p => propertyType == p.PropertyType);
                }

            }

            // Execute the query and return the results
            var properties = await query.ToArrayAsync();

            foreach (var property in properties)
            {
                var locationRes = await _redHouseDbContext.Locations.FirstOrDefaultAsync(l => l.Id == property.LocationId);
                property.Location = locationRes;
            }

            if (filterDto.LocationDto != null)
            {
                if (!string.IsNullOrEmpty(filterDto.LocationDto.City))
                {
                    properties = properties.Where(p => p.Location.City == filterDto.LocationDto.City).ToArray();
                }

                if (!string.IsNullOrEmpty(filterDto.LocationDto.Region))
                {
                    properties = properties.Where(p => p.Location.Region == filterDto.LocationDto.Region).ToArray();
                }

                if (!string.IsNullOrEmpty(filterDto.LocationDto.Country))
                {
                    properties = properties.Where(p => p.Location.Country == filterDto.LocationDto.Country).ToArray();
                }

                if (!string.IsNullOrEmpty(filterDto.LocationDto.StreetAddress))
                {
                    properties = properties.Where(p => p.Location.StreetAddress == filterDto.LocationDto.StreetAddress).ToArray();
                }

                if (!string.IsNullOrEmpty(filterDto.LocationDto.PostalCode))
                {
                    properties = properties.Where(p => p.Location.PostalCode == filterDto.LocationDto.PostalCode).ToArray();
                }

                if (!string.IsNullOrEmpty(filterDto.LocationDto.Latitude) && !string.IsNullOrEmpty(filterDto.LocationDto.Longitude))
                {
                    double latitude;
                    double longitude;

                    if (double.TryParse(filterDto.LocationDto.Latitude, out latitude) && double.TryParse(filterDto.LocationDto.Longitude, out longitude))
                    {
                        properties = properties.Where(p => p.Location.Latitude == latitude && p.Location.Longitude == longitude).ToArray();
                    }
                }
            }



            return new ResponsDto<Property>
            {
                ListDto = properties,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Property>> GetAllPropertiesForUser(int userId)
        {
            // Create a queryable variable based on the DbSet
            var query = _redHouseDbContext.Properties.AsQueryable();

            query = query.Where(p => p.UserId == userId);
            query = query.Include(p => p.propertyFiles).Include(p => p.User).Include(p => p.Location);
            var properties = query.ToArray();

            return new ResponsDto<Property>
            {
                ListDto = properties,
                StatusCode = HttpStatusCode.OK,
            };
        }



        public async Task<ResponsDto<Property>> GetProperty(int propertyId)
        {
            var property = await _redHouseDbContext.Properties.FindAsync(propertyId);
            if (property == null)
            {
                return new ResponsDto<Property>
                {
                    Message = $"Property with {propertyId} Id Dose Not Exist",
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            return new ResponsDto<Property>
            {
                Dto = property,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Property>> UpdateProperty(PropertyDto propertyDto, int propertyId)
        {
            var property = await _redHouseDbContext.Properties.FindAsync(propertyId);
            if (property == null)
            {
                return new ResponsDto<Property>
                {
                    Exception = new Exception($"Property with {propertyId} Dose Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            Property updatedProperty = new Property
            {
                AvailableOn = propertyDto.AvailableOn,
                BuiltYear = propertyDto.BuiltYear,
                IsAvailableBasement = propertyDto.IsAvailableBasement,
                ListingBy = propertyDto.ListingBy,
                ListingType = propertyDto.ListingType,
                LocationId = 0,
                // NeighborhoodId = 0,
                NumberOfBathRooms = propertyDto.NumberOfBathRooms,
                NumberOfBedRooms = propertyDto.NumberOfBedRooms,
                NumberOfUnits = propertyDto.NumberOfUnits,
                ParkingSpots = propertyDto.ParkingSpots,
                Price = propertyDto.Price,
                PropertyDescription = propertyDto.PropertyDescription,
                PropertyStatus = propertyDto.PropertyStatus,
                PropertyType = propertyDto.PropertyType,
                SquareMetersArea = propertyDto.SquareMeter,
                UserId = propertyDto.UserId,
                View = propertyDto.View,
            };
            _redHouseDbContext.Properties.Update(updatedProperty);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Property>
            {
                Message = $"Property with {propertyId} Id Updated succssfully",
                StatusCode = HttpStatusCode.OK,
            };
        }

        

        public async Task<ResponsDto<Offer>> GetPricePropertyHistory(int propertyId)
        {
            var property = await _redHouseDbContext.Properties.FindAsync(propertyId);
            if (property == null)
            {
                return new ResponsDto<Offer>
                {
                    Message = $"Property with {propertyId} Id Dose Not Exist",
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }


            var acceptedOffers = _redHouseDbContext.Offers
                .Where(o => o.PropertyId == propertyId && o.OfferStatus == "Accepted")
                .Include(o => o.Property) // Include the Property navigation property
                .Include(o => o.Landlord) // Include the Landlord navigation property
                .Include(o => o.Customer) // Include the Customer navigation property
                .ToList();

            return new ResponsDto<Offer>
            {
                ListDto = acceptedOffers,
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}
