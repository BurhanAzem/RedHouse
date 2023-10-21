using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Models;
using Cooking_School.Dtos;

namespace RedHouse_Server.Services
{
    public interface IAuthServices
    {
        public Task<ResponsDto<User>> RegisterUser(RegisterDto registerDto);
        public Task<ResponsDto<User>> LoginUser(LoginDto loginDto);
        public Task<ResponsDto<User>> Logout();
    }
}
