using System;
using System.Net;
using Cooking_School.Dtos;
using Microsoft.EntityFrameworkCore;
using RedHouse_Server.Dtos.ComplainDtos;
using RedHouse_Server.Dtos.ContractDtos;
using RedHouse_Server.Models;
using server.Models;

namespace server.Services
{
    public class ComplainServices : IComplainServices
    {
        private RedHouseDbContext _redHouseDbContext;
        public ComplainServices(RedHouseDbContext blueHouseDbContext)
        {
            _redHouseDbContext = blueHouseDbContext;
        }

        public async Task<ResponsDto<Complain>> CreateComplain(ComplainDto complainDto)
        {
            var customer = await _redHouseDbContext.Users.FindAsync(complainDto.UserId);
            if (customer == null)
            {
                return new ResponsDto<Complain>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            Complain complain = new Complain
            {
                UserId = complainDto.UserId,
                Description = complainDto.Description,
                ComplainDate = DateTime.Now,
            };
            var offerRes = await _redHouseDbContext.Complains.AddAsync(complain);
            _redHouseDbContext.SaveChanges();

            return new ResponsDto<Complain>
            {
                Dto = offerRes.Entity,
                Message = "Complain Created Successfully",
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Complain>> GetComplain(int complainId)
        {
            var complain = await _redHouseDbContext.Complains.FindAsync(complainId);
            if (complain == null)
            {
                return new ResponsDto<Complain>
                {
                    Exception = new Exception("Complain Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            return new ResponsDto<Complain>
            {
                Dto = complain,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Complain>> GetComplains(int userId)
        {
             var user = await _redHouseDbContext.Users.FindAsync(userId);
            if (user == null)
            {
                return new ResponsDto<Complain>
                {
                    Exception = new Exception($"User with {userId} Id Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            // Define a separate method without optional arguments
            
            var complains = await _redHouseDbContext.Complains.Where(c => c.UserId == userId).ToArrayAsync();

            return new ResponsDto<Complain>
            {
                ListDto = complains,
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}
