using System;
using Cooking_School.Dtos;
using RedHouse_Server.Dtos.UserHistoryDtos;
using server.Models;

namespace server.Services
{
    public interface IUserHistoryServices
    {
        public Task<ResponsDto<UserHistory>> AddToUserHistory(UserHistoryDto userHistoryDto);
        public Task<ResponsDto<UserHistory>> GetUserHistory(int userId);
        // public Task<ResponsDto<UserHistory>> GetUserHistory(int applicationId);
        public Task<ResponsDto<UserHistory>> GetPropertyHistory(int propertyId);

        public Task<ResponsDto<UserHistory>> DeleteUserHistory(int userId);
        public Task<ResponsDto<UserHistory>> UpdateUserHistory(UserHistoryDto userHistoryDto, int userId);
    }
}
