using System;
using Cooking_School.Dtos;
using RedHouse_Server.Dtos.ContractDtos;
using RedHouse_Server.Models;

namespace server.Services
{
    public interface IContractServices
    {
        public Task<ResponsDto<Contract>> CreateContract(ContractDto contractDto);
        public Task<ResponsDto<Contract>> GetAllContracts();
        public Task<ResponsDto<Contract>> GetAllContractsForUser(int userId, ContractFilter contractFilter);
        public Task<ResponsDto<Contract>> GetContract(int contractId);
        public Task<ResponsDto<Contract>> DeleteContract(int contractId);
        public Task<ResponsDto<Contract>> UpdateContract(ContractDto contractDto, int contractId);
        public Task<int> NumberOfContracts();
        public Task<ResponsDto<Contract>> FilterContracts(SearchDto searchDto);

    }
}
