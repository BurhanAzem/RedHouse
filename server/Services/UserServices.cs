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

        public async Task<ResponsDto<User>> GetAgents(string userName, int pageNumber = 1, int pageSize = 10)
        {
            // Validate and adjust page number and page size if needed
            pageNumber = pageNumber < 1 ? 1 : pageNumber;
            pageSize = pageSize < 1 ? 10 : pageSize;

            var query = _redHouseDbContext.Users.Where(u => u.Name.Contains(userName));

            var totalItems = await query.CountAsync();
            var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var users = await query
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize)
                .ToArrayAsync();

            if (users == null || !users.Any())
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception("Users Not Found"),
                    StatusCode = HttpStatusCode.NotFound,
                };
            }

            return new ResponsDto<User>
            {
                ListDto = users,
                // PageNumber = pageNumber,
                // PageSize = pageSize,
                // TotalItems = totalItems,
                // TotalPages = totalPages,
                StatusCode = HttpStatusCode.OK,
            };
        }



        public async Task<ResponsDto<User>> GetAllUsers(int pageNumber = 1, int pageSize = 10)
        {
            // Validate and adjust page number and page size if needed
            pageNumber = pageNumber < 1 ? 1 : pageNumber;
            pageSize = pageSize < 1 ? 10 : pageSize;

            var query = _redHouseDbContext.Users;

            var totalItems = await query.CountAsync();
            var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var users = await query
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize)
                .ToArrayAsync();

            if (users == null || !users.Any())
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception("Users Not Found"),
                    StatusCode = HttpStatusCode.NotFound,
                };
            }

            return new ResponsDto<User>
            {
                ListDto = users,
                // PageNumber = pageNumber,
                // PageSize = pageSize,
                // TotalItems = totalItems,
                // TotalPages = totalPages,
                StatusCode = HttpStatusCode.OK,
            };
        }


        // public async Task<ResponsDto<User>> GetApplication(int applicationId)
        // {
        //     var users = await _redHouseDbContext.Users.ToArrayAsync();

        //     return new ResponsDto<User>
        //     {
        //         ListDto = users,
        //         StatusCode = HttpStatusCode.OK,
        //     };
        // }

        public async Task<ResponsDto<User>> GetUser(int userId)
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

            return new ResponsDto<User>
            {
                Dto = user,
                StatusCode = HttpStatusCode.BadRequest,
            };
        }

    }
}
