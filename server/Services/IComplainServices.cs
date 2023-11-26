using System;
using Cooking_School.Dtos;
using RedHouse_Server.Dtos.ApplicationDtos;
using RedHouse_Server.Dtos.ComplainDtos;
using RedHouse_Server.Models;
using server.Models;

namespace server.Services
{
    public interface IComplainServices
    {
        public Task<ResponsDto<Complain>> CreateComplain(ComplainDto complainDto);
        public Task<ResponsDto<Complain>> GetComplains(int userId);
        public Task<ResponsDto<Complain>> GetComplain(int complainId);

    }
}
