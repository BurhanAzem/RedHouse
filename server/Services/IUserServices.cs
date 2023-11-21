using System;
using Cooking_School.Dtos;
using RedHouse_Server.Models;

namespace server.Services
{
    public interface IUserServices
    {
        // public Task<ResponsDto<User>> CreateApplication(ApplicationDto applicationDto);
        public Task<ResponsDto<User>> GetUsersOfApprovedApplications(int userId);
        public Task<ResponsDto<User>> GetApplication(int applicationId);
    }
}
