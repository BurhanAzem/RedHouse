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

        public async Task<ResponsDto<Application>> GetApplications(int userId, ApplicationFilter applicationFilter)
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

            var query = _redHouseDbContext.Applications.Include(a => a.User)
                .Include(a => a.Property)
                .ThenInclude(p => p.Location)
                .AsQueryable();

            if (applicationFilter.ApplicationTo.Trim() == "Landlord")
            {
                query = from p in _redHouseDbContext.Properties
                        join a in query on p.Id equals a.PropertyId
                        where p.UserId == userId
                        select a;

            }

            // Now you can use the 'query' variable for further processing

            if (applicationFilter.ApplicationTo.Trim() == "Customer")
            {
                query = query.Where(a => a.UserId == userId);
            }
            if (applicationFilter.ApplicationType.Trim() != "All")
            {
                query = query.Where(a => a.Property.ListingType == applicationFilter.ApplicationType.Trim());
            }
            if (applicationFilter.ApplicationStatus.Trim() != "All")
            {
                query = query.Where(c => c.ApplicationStatus == applicationFilter.ApplicationStatus.Trim());
            }

            var applications = query.ToList();

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

        public async Task<ResponsDto<Application>> ApproveApplication(int applicationId)
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
            application.ApplicationStatus = "Approved";
            _redHouseDbContext.Applications.Update(application);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Application>
            {
                Dto = application,
                Exception = new Exception($"Application with {applicationId} Approved succussfuly"),
                StatusCode = HttpStatusCode.OK,
            };
        }

        public async Task<ResponsDto<Application>> RejectApplication(int applicationId)
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
            application.ApplicationStatus = "Rejected";
            _redHouseDbContext.Applications.Update(application);
            _redHouseDbContext.SaveChanges();
            return new ResponsDto<Application>
            {
                Dto = application,
                Exception = new Exception($"Application with {applicationId} Rejected succussfuly"),
                StatusCode = HttpStatusCode.OK,
            };
        }
    }
}


