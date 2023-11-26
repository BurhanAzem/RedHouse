using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;
using server.Dtos.PropertyDtos;
using server.Models;

namespace RedHouse_Server.Services
{
    public interface IPropertyServices
    {
        public Task<ResponsDto<Property>> AddProperty(PropertyDto propertyDto);
        public Task<ResponsDto<Property>> GetProperty(int propertyId);
        public Task<ResponsDto<Property>> GetProperties(FilterDto filterDto);
        public Task<ResponsDto<Property>> GetAllPropertiesForUser(int userId);
        public Task<ResponsDto<Property>> DeleteProperty(int propertyId);
        public Task<ResponsDto<Property>> UpdateProperty(PropertyDto propertyDto, int propertyId);
        public Task<List<int>> GetPricePropertyHistoryAsRent(int propertyId);
        public Task<List<int>> GetPricePropertyHistoryAsSell(int propertyId);
        public Task<List<int>> GetNumberOfPropertiesInLastTenYears();
        public Task<int> NumberOfProperties();


    }
}
