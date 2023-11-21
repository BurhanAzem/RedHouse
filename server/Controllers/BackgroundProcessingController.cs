using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Services;
using Cooking_School.Core.ModelUsed;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using server.Dtos.PropertyDtos;
using Microsoft.AspNetCore.Authorization;
using server.Services;
using RedHouse_Server.Dtos.ApplicationDtos;
using Hangfire;

namespace RedHouse_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BackgroundProcessingController : ControllerBase
    {
        private IMilestoneServices _milestoneServices;

        public BackgroundProcessingController(IMilestoneServices milestoneServices)
        {
            _milestoneServices = milestoneServices;
        }
        
        // [Authorize]
        [HttpPost("/scheduale-milestone/{userId}")]
        public async Task<IActionResult> CreateMonthlyMilestone(int userId)
        {
            RecurringJob.AddOrUpdate("RecurringJob1", () => _milestoneServices.CreateMonthlyMilestone(userId), Cron.Daily);
            return Ok();

        }

        
    }
}



