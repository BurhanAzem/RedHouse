using System;
using Cooking_School.Dtos;
using RedHouse_Server.Models;

namespace server.Services
{
    public interface IUserServices
    {
        public Task<ResponsDto<User>> GetUsersOfApprovedApplications(int userId);
        public Task<int> NumberOfUsers();
        public Task<ResponsDto<User>> FilterAgents(SearchDto searchDto);
        public Task<ResponsDto<User>> FilterUsers(SearchDto searchDto);
        public Task<ResponsDto<User>> GetUser(int userId);
        // public Task<ResponsDto<User>> GetAllUsers(int pageNumber = 1, int pageSize = 10);

        public Task<List<int>> GetNumberOfUsersInLastTenYears();

    }
}
