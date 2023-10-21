using AutoMapper;
using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Migrations;
using RedHouse_Server.Models;
using Cooking_School.Dtos;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace RedHouse_Server.Services
{
    public class AuthServices : IAuthServices
    {
        private UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly RedHouseDbContext _redHouseDbContext;
        private IConfiguration _configuration;
        private readonly IMapper _mapper;
        public AuthServices(UserManager<IdentityUser> userManager, IMapper mapper, RedHouseDbContext redHouseDbContext, IConfiguration configuration, SignInManager<IdentityUser> signInManager)
        {
            _userManager = userManager;
            _mapper = mapper;
            _redHouseDbContext = redHouseDbContext;
            _configuration = configuration;
            _signInManager = signInManager;
        }

        public async Task<ResponsDto<User>> RegisterUser(RegisterDto registerDto)
        {
            var res = await _userManager.FindByEmailAsync(registerDto.Email!);
            if (res != null)
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception("User Already Exist"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            if (registerDto == null)
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception("Rigister user is null"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            var user = _mapper.Map<User>(registerDto);

            var identityUser = new IdentityUser
            {
                Email = registerDto.Email,
                UserName = registerDto.Email,

            };




            var result = await _userManager.CreateAsync(identityUser, registerDto.Password!);
            if (result.Succeeded)
            {
                var location = new Location();
                location.PostalCode = registerDto.ZipCode;

                // Assuming _context is your DbContext
                var resLocation = await _redHouseDbContext.Locations.AddAsync(location);
                await _redHouseDbContext.SaveChangesAsync(); // Persist changes to the database

                user.LocationId = resLocation.Entity.Id; // Access the ID of the added location

                await _redHouseDbContext.Users.AddAsync(user);
                await _redHouseDbContext.SaveChangesAsync();
                return new ResponsDto<User>
                {
                    Message = "User created successfuly!",
                    StatusCode = HttpStatusCode.OK,
                    Dto = user,
                };
            }
            else
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception(string.Join(", ", result.Errors.Select(e => e.Description))),
                    StatusCode = HttpStatusCode.BadRequest,
                    Message = string.Join(", ", result.Errors.Select(e => e.Description))
                };
            };
        }


        public async Task<ResponsDto<User>> LoginUser(LoginDto loginDto)
        {
            // Use a try-catch block to handle exceptions.
            try
            {
                User loginUser = await _redHouseDbContext.Users.FirstOrDefaultAsync(x => x.Email == loginDto.Email);
                var user = await _userManager.FindByEmailAsync(loginDto.Email);
                if (user == null)
                {
                    return new ResponsDto<User>
                    {
                        Exception = new Exception("User Not found"),
                        StatusCode = HttpStatusCode.BadRequest,
                    };
                }

                var result = await _signInManager.PasswordSignInAsync(user, loginDto.Password, true, lockoutOnFailure: false);
                if (result.Succeeded)
                {
                    return new ResponsDto<User>
                    {
                        Message = "You are logged in successfully",
                        StatusCode = HttpStatusCode.OK,
                        Dto = loginUser
                    };
                }

                return new ResponsDto<User>
                {
                    Exception = new Exception("Invalid login attempt."),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }
            catch (Exception ex)
            {
                // Handle and log exceptions as needed.
                return new ResponsDto<User>
                {
                    Exception = ex,
                    StatusCode = HttpStatusCode.InternalServerError,
                };
            }
        }

        public async Task<ResponsDto<User>> Logout()
        {
            await _signInManager.SignOutAsync();
            return new ResponsDto<User>
            {
                Message = "You are logOut sucssefully",
                StatusCode = HttpStatusCode.OK,
            };
        }
    }

}
