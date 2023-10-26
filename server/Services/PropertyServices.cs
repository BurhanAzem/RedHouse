using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;
using System.Net;
using server.Dtos.PropertyDtos;
using Microsoft.EntityFrameworkCore;

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

            Location location = new Location{
                City = propertyDto.LocationDto.City,
                Country = propertyDto.LocationDto.Country,
                Region = propertyDto.LocationDto.Region,
                PostalCode = propertyDto.LocationDto.PostalCode,
                StreetAddress = propertyDto.LocationDto.StreetAddress,
                Latitude = propertyDto.LocationDto.Latitude,
                Longitude =propertyDto.LocationDto.Longitude,
            } ;
            var locationRes = await _redHouseDbContext.Locations.AddAsync(location);
            Property property = new Property
            {
                AvailableOn = propertyDto.AvailableOn,
                BuiltYear = propertyDto.BuiltYear,
                IsAvailableBasement = propertyDto.IsAvailableBasement,
                ListingBy = propertyDto.ListingBy,
                ListingType = propertyDto.ListingType,
                LocationId = locationRes.Entity.Id,
                NeighborhoodId = 0,
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
                await _redHouseDbContext.Files.AddAsync(propertyFile);
                await _redHouseDbContext.SaveChangesAsync();
            }
            return new ResponsDto<Property>
            {
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

    // // Apply filtering based on the filterDto, if provided
    // if (!string.IsNullOrEmpty(filterDto.SomeFilterProperty))
    // {
    //     query = query.Where(p => p.SomeProperty == filterDto.SomeFilterProperty);
    // }
    
    // Execute the query and return the results
    var properties = await query.ToArrayAsync();

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
                NeighborhoodId = 0,
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
    }
}
