using AutoMapper;
using BlueHouse_Server.Dtos.AuthDtos;
using BlueHouse_Server.Migrations;
using BlueHouse_Server.Models;
using Cooking_School.Dtos;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using System.Text;

namespace BlueHouse_Server.Services
{
    public class AuthServices : IAuthServices
    {
        private UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        private RedHouseDbContext _blueHouseDbContext;
        private IConfiguration _configuration;
        private readonly IMapper _mapper;
        public AuthServices(UserManager<IdentityUser> userManager, IMapper mapper, RedHouseDbContext blueHouseDbContext, IConfiguration configuration, SignInManager<IdentityUser> signInManager)
        {
            _userManager = userManager;
            _mapper = mapper;
            _blueHouseDbContext = blueHouseDbContext;
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
                var resLocation = await _blueHouseDbContext.Locations.AddAsync(location);
                await _blueHouseDbContext.SaveChangesAsync(); // Persist changes to the database

                user.LocationId = resLocation.Entity.Id; // Access the ID of the added location

                await _blueHouseDbContext.Users.AddAsync(user);
                await _blueHouseDbContext.SaveChangesAsync();
                return new ResponsDto<User>
                {
                    Message = "User created successfuly!",
                    StatusCode = HttpStatusCode.OK,
                    Dto = user
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
            var user = await _userManager.FindByEmailAsync(loginDto.Email);
            if (user == null)
            {
                return new ResponsDto<User>
                {
                    Exception = new Exception("User Not found"),
                    StatusCode = HttpStatusCode.BadRequest,
                };
            }

            var result = await _signInManager.PasswordSignInAsync(loginDto.Email, loginDto.Password, true, lockoutOnFailure: false);
            if (result.Succeeded)
            {
                return new ResponsDto<User>
                {
                    Message = "You are login sucssefully",
                    StatusCode = HttpStatusCode.OK,
                };
            }

            return new ResponsDto<User>
            {
                Exception = new Exception("Invalid login attempt.\""),
                StatusCode = HttpStatusCode.BadRequest,
            };

            //var user = await _userManager.FindByEmailAsync(loginDto.Email);
            //if (user == null)
            //{
            //    return new ResponsDto<User>
            //    {
            //        Exception = new Exception("User Not found"),
            //        StatusCode = HttpStatusCode.BadRequest,
            //    };
            //}

            //var result = await _userManager.CheckPasswordAsync(user, loginDto.Password);
            //if(!result)
            //{
            //    return new ResponsDto<User>
            //    {
            //        Exception = new Exception("Invalid Password"),
            //        StatusCode = HttpStatusCode.BadRequest,
            //    };
            //}

            //var claims = new[]
            //{
            //    new Claim("Email", loginDto.Email),
            //    new Claim(ClaimTypes.NameIdentifier, user.Id),
            //};

            //var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["AuthSettings:Key"]));

            //var token = new JwtSecurityToken(
            //    //issuer: _configuration["AuthSettings:Issuer"],
            //    //audience: _configuration["AuthSettings:Audience"],
            //    claims: claims,
            //    expires: DateTime.Now.AddDays(1),
            //    signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256)
            //    );
            //string tokenAssString = new JwtSecurityTokenHandler().WriteToken(token);


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
