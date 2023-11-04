using System;
using Cooking_School.Dtos;
using RedHouse_Server.Dtos.ApplicationDtos;
using RedHouse_Server.Models;
using System.Net;
using Microsoft.EntityFrameworkCore;

namespace server.Services
{
    public class ApplicationServices : IApplicationServices
    {
        private RedHouseDbContext _redHouseDbContext;
        public ApplicationServices(RedHouseDbContext blueHouseDbContext)
        {
            _redHouseDbContext = blueHouseDbContext;
        }
        public async Task<ResponsDto<Application>> CreateApplication(ApplicationDto applicationDto)
        {
            var user = await _redHouseDbContext.Users.FindAsync(applicationDto.UserId);
            if (user == null)
            {
                return new ResponsDto<Application>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            var property = await _redHouseDbContext.Properties.FindAsync(applicationDto.PropertyId);
            if (user == null)
            {
                return new ResponsDto<Application>
                {
                    Exception = new Exception("Property Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            Application application = new Application
            {
                UserId = applicationDto.UserId,
                PropertyId = applicationDto.PropertyId,
                ApplicationDate = DateTime.Now,
                ApplicationStatus = "Pending",
                ApplicationType = applicationDto.ApplicationType
            };
            var applicationRes = await _redHouseDbContext.Applications.AddAsync(application);
            await _redHouseDbContext.SaveChangesAsync();

            return new ResponsDto<Application>
            {
                Dto = applicationRes.Entity,
                Message = "Application Added Successfully",
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Application>> GetApplication(int applicationId)
        {

            var property = await _redHouseDbContext.Properties.FindAsync(applicationId);
            if (property == null)
            {
                return new ResponsDto<Application>
                {
                    Exception = new Exception("Property Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            var application = await _redHouseDbContext.Applications.FindAsync(applicationId);
            var user = await _redHouseDbContext.Users.FirstOrDefaultAsync(u => u.Id == application.UserId);

            application.User = user;
            application.Property = property;

            return new ResponsDto<Application>
            {
                Dto = application,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Application>> GetApplications(int userId)
        {
            var user = await _redHouseDbContext.Users.FindAsync(userId);
            if (user == null)
            {
                return new ResponsDto<Application>
                {
                    Exception = new Exception("User Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            List<Application> applications = _redHouseDbContext.Applications.Where(a => a.UserId == userId).ToList();
            foreach (var application in applications)
            {
                var appUser = await _redHouseDbContext.Users.FirstOrDefaultAsync(u => u.Id == application.UserId);
                var appProperty = await _redHouseDbContext.Properties.Include(p => p.propertyFiles).FirstOrDefaultAsync(p => p.Id == application.PropertyId);
                var location = await _redHouseDbContext.Locations.FirstOrDefaultAsync(l => l.Id == appProperty.LocationId);
                application.User = appUser;
                application.Property = appProperty;
            }
            return new ResponsDto<Application>
            {
                ListDto = applications,
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Application>> DeleteApplication(int applicationId)
        {
            var application = await _redHouseDbContext.Applications.FindAsync(applicationId);
            if (application == null)
            {
                return new ResponsDto<Application>
                {
                    Exception = new Exception($"Application with {applicationId} Dose Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            _redHouseDbContext.Applications.Remove(application);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Application>
            {
                Exception = new Exception($"Application with {applicationId} Deleted succussfuly"),
                StatusCode = HttpStatusCode.OK,
            };
        }


        public async Task<ResponsDto<Application>> UpdateApplication(ApplicationDto applicationDto, int applicationId)
        {
            var property = await _redHouseDbContext.Applications.FindAsync(applicationId);
            if (property == null)
            {
                return new ResponsDto<Application>
                {
                    Exception = new Exception($"Application with {applicationId} Dose Not Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            Application updatedApplication = new Application
            {
                ApplicationDate = applicationDto.ApplicationDate,
                ApplicationStatus = applicationDto.ApplicationStatus,
                ApplicationType = applicationDto.ApplicationType,
                Message = applicationDto.Message,
                PropertyId = applicationDto.PropertyId,
                UserId = applicationDto.UserId
            };
            _redHouseDbContext.Applications.Update(updatedApplication);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Application>
            {
                Message = $"Application with {applicationId} Id Updated succssfully",
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}


