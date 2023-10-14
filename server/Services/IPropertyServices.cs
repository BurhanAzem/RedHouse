using BlueHouse_Server.Dtos.AuthDtos;
using BlueHouse_Server.Dtos.PropertyDtos;
using BlueHouse_Server.Models;
using Cooking_School.Dtos;

namespace BlueHouse_Server.Services
{
    public interface IPropertyServices
    {
        public Task<ResponsDto<Property>> AddProperty(PropertyDto propertyDto);

    }
}
