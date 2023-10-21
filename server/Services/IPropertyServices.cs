using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;

namespace RedHouse_Server.Services
{
    public interface IPropertyServices
    {
        public Task<ResponsDto<Property>> AddProperty(PropertyDto propertyDto);

    }
}
