using System;
using Cooking_School.Dtos;
using Microsoft.AspNetCore.Mvc;
using RedHouse_Server.Dtos.ApplicationDtos;
using RedHouse_Server.Dtos.ComplainDtos;
using RedHouse_Server.Models;
using server.Models;

namespace server.Services
{
    public interface IComplaintServices
    {
        public Task<ResponsDto<Complaint>> CreateComplain(ComplaintDto complainDto);
        public Task<ResponsDto<Complaint>> GetComplaints(int userId);
        public Task<ResponsDto<Complaint>> GetComplain(int complainId);
        public Task<IActionResult> GetNumberOfComplaintsPerDay(int page = 1, int limit = 10);
        public Task<IActionResult> GetComplaintsForDay(DateTime day);


    }
}
