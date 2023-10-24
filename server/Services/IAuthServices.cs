using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;
using Microsoft.AspNetCore.Identity;

namespace RedHouse_Server.Services
{
    public interface IAuthServices
    {
        public Task<ResponsDto<User>> RegisterUser(RegisterDto registerDto);
        public Task<ResponsDto<string>> LoginUser(LoginDto loginDto);
        public Task<ResponsDto<User>> Logout();
        public string GenerateJwtToken(IdentityUser user);

    }
}
