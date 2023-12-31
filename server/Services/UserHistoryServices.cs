using System;
using System.Net;
using Cooking_School.Dtos;
using Microsoft.EntityFrameworkCore;
using RedHouse_Server.Dtos.UserHistoryDtos;
using RedHouse_Server.Models;
using server.Models;

namespace server.Services
{
    public class UserHistoryServices : IUserHistoryServices
    {
        private RedHouseDbContext _redHouseDbContext;
        public UserHistoryServices(RedHouseDbContext blueHouseDbContext)
        {
            _redHouseDbContext = blueHouseDbContext;
        }
        public Task<ResponsDto<UserHistory>> AddToUserHistory(UserHistoryDto userHistoryDto)
        {
            throw new NotImplementedException();
        }

        public Task<ResponsDto<UserHistory>> DeleteUserHistory(int userId)
        {
            throw new NotImplementedException();
        }

        public async Task<ResponsDto<UserHistory>> GetUserHistory(int userId)
        {
            var user = await _redHouseDbContext.Users.FindAsync(userId);
            if (user == null)
            {
                return new ResponsDto<UserHistory>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }



            var contracts = _redHouseDbContext.Contracts
    .Where(c => c.Offer.CustomerId == userId)
    .Include(c => c.Offer.Property).ThenInclude(p => p.Location).Include(p => p.Offer.Property.propertyFiles) // Include the Property navigation property
    .Include(c => c.Offer.Landlord) // Include the Landlord navigation property
    .Include(c => c.Offer.Customer) // Include the Customer navigation property
    .ToList();

            var userHistories = _redHouseDbContext.UserHistoryRecords
                .ToList()
                .Join(
                    contracts,
                    uh => uh.ContractId,
                    c => c.Id,
                    (uh, c) => new UserHistory
                    {
                        Id = uh.Id,
                        ContractId = uh.ContractId,
                        FeedbackToLandlord = uh.FeedbackToLandlord,
                        FeedbackToCustomer = uh.FeedbackToCustomer,
                        CustomerRating = uh.CustomerRating,
                        LandlordRating = uh.LandlordRating,
                        Contract = c
                    }
                )
                .ToList();





            return new ResponsDto<UserHistory>
            {
                ListDto = userHistories,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public Task<ResponsDto<UserHistory>> UpdateUserHistory(UserHistoryDto userHistoryDto, int userId)
        {
            throw new NotImplementedException();
        }

        public async Task<ResponsDto<UserHistory>> GetPropertyHistory(int propertyId)
        {

            var property = await _redHouseDbContext.Properties.FindAsync(propertyId);
            if (property == null)
            {
                return new ResponsDto<UserHistory>
                {
                    Message = $"Property with {propertyId} Id Dose Not Exist",
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }




            var contracts = _redHouseDbContext.Contracts
                .Where(c => c.Offer.PropertyId == propertyId)
                .Include(c => c.Offer.Property) // Include the Property navigation property
                .Include(c => c.Offer.Landlord) // Include the Landlord navigation property
                .Include(c => c.Offer.Customer) // Include the Customer navigation property
                .ToList();

            var userHistories = _redHouseDbContext.UserHistoryRecords
                .ToList()
                .Join(
                    contracts,
                    uh => uh.ContractId,
                    c => c.Id,
                    (uh, c) => new UserHistory
                    {
                        Id = uh.Id,
                        ContractId = uh.ContractId,
                        FeedbackToLandlord = uh.FeedbackToLandlord,
                        FeedbackToCustomer = uh.FeedbackToCustomer,
                        CustomerRating = uh.CustomerRating,
                        LandlordRating = uh.LandlordRating,
                        Contract = c
                    }
                )
                .ToList();

            return new ResponsDto<UserHistory>
            {
                ListDto = userHistories,
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}
