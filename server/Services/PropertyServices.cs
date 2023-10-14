using BlueHouse_Server.Dtos.PropertyDtos;
using BlueHouse_Server.Models;
using Cooking_School.Dtos;
using System.Net;

namespace BlueHouse_Server.Services
{
    public class PropertyServices : IPropertyServices
    {
        private RedHouseDbContext _blueHouseDbContext;
        public PropertyServices(RedHouseDbContext blueHouseDbContext) 
        {
            _blueHouseDbContext = blueHouseDbContext;
        }
        public async Task<ResponsDto<Property>> AddProperty(PropertyDto propertyDto)
        {
            var user = await _blueHouseDbContext.Users.FindAsync(propertyDto.UserId);
            if (user == null) 
            {
                return new ResponsDto<Property>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            //var location = await _blueHouseDbContext.Locations.AddAsync(propertyDto.LocationDto);
            return new ResponsDto<Property>
            {
                Exception = new Exception("Proprety Added Successfully"),
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}
