using System;
using System.Net;
using Cooking_School.Dtos;
using Microsoft.EntityFrameworkCore;
using RedHouse_Server.Models;

namespace server.Services
{
    public class UserServices : IUserServices
    {

        private RedHouseDbContext _redHouseDbContext;
        public UserServices(RedHouseDbContext refHouseDbContext)
        {
            _redHouseDbContext = refHouseDbContext;
        }
        public Task<ResponsDto<User>> GetApplication(int applicationId)
        {
            throw new NotImplementedException();
        }

        public async Task<ResponsDto<User>> GetUsersOfApprovedApplications(int userId)
        {
            var user = await _redHouseDbContext.Users.FindAsync(userId);
            if (user == null)
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            var applications = await _redHouseDbContext.Applications.Include(a => a.Property).AsQueryable()
                                    .Where(a => a.Property.UserId == userId && a.ApplicationStatus == "Approved").ToArrayAsync();
            List<User> users = new List<User>();

            foreach (var application in applications)
            {
                users.Add(await _redHouseDbContext.Users.FindAsync(application.UserId));
            }
            return new ResponsDto<User>
            {
                ListDto = users,
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}
