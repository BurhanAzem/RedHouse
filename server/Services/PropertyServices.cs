using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;
using System.Net;

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
            //var location = await _blueHouseDbContext.Locations.AddAsync(propertyDto.LocationDto);
            Property property = new Property{
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
            var propertyRes = await _redHouseDbContext.Properties.AddAsync(property);
            await _redHouseDbContext.SaveChangesAsync();
            int propertyId = propertyRes.Entity.Id;
            foreach (var file in propertyDto.PropertyFiles)
            {
                PropertyFile propertyFile = new PropertyFile {
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
    }
}
