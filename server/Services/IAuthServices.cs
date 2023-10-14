using BlueHouse_Server.Dtos.AuthDtos;
using BlueHouse_Server.Models;
using Cooking_School.Dtos;

namespace BlueHouse_Server.Services
{
    public interface IAuthServices
    {
        public Task<ResponsDto<User>> RegisterUser(RegisterDto registerDto);
        public Task<ResponsDto<User>> LoginUser(LoginDto loginDto);

        public Task<ResponsDto<User>> Logout();
    }
}
