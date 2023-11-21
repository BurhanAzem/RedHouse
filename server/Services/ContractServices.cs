using System;
using System.Net;
using Cooking_School.Dtos;
using Microsoft.EntityFrameworkCore;
using RedHouse_Server.Dtos.ContractDtos;
using RedHouse_Server.Models;

namespace server.Services
{
    public class ContractServices : IContractServices
    {
        private RedHouseDbContext _redHouseDbContext;
        public ContractServices(RedHouseDbContext blueHouseDbContext)
        {
            _redHouseDbContext = blueHouseDbContext;
        }
        public Task<ResponsDto<Contract>> CreateContract(ContractDto contractDto)
        {
            throw new NotImplementedException();
        }

        public Task<ResponsDto<Contract>> DeleteContract(int contractId)
        {
            throw new NotImplementedException();
        }

        public Task<ResponsDto<Contract>> GetAllContracts()
        {
            throw new NotImplementedException();
        }

        public async Task<ResponsDto<Contract>> GetAllContractsForUser(int userId, ContractFilter contractFilter)
        {
            var query = _redHouseDbContext.Contracts.Include(c => c.Offer.Landlord).Include(c => c.Offer.Customer).Include(c => c.Offer.Property).AsQueryable();
            if (contractFilter.ContractTo.Trim() == "Landlord")
            {
                query = query.Where(c => c.Offer.LandlordId == userId);
            }
            if (contractFilter.ContractTo.Trim() == "Customer")
            {
                query = query.Where(c => c.Offer.CustomerId == userId);
            }
            if (contractFilter.ContractType.Trim() != "All")
            {
                query = query.Where(c => c.ContractType == contractFilter.ContractType.Trim());
            }
            if (contractFilter.ContractStatus.Trim() != "All")
            {
                query = query.Where(c => c.ContractStatus == contractFilter.ContractStatus.Trim());
            }
            var contracts = query.ToArray();

            return new ResponsDto<Contract>
            {
                ListDto = contracts,
                StatusCode = HttpStatusCode.OK,
            };
        }


        public Task<ResponsDto<Contract>> GetContract(int contractId)
        {
            throw new NotImplementedException();
        }

        public Task<ResponsDto<Contract>> UpdateContract(ContractDto contractDto, int contractId)
        {
            throw new NotImplementedException();
        }
    }
}
