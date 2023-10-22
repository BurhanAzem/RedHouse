using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Services;
using Cooking_School.Core.ModelUsed;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
namespace RedHouse_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private IAuthServices _authServices;
        public UserController(IAuthServices authServices)
        {
            _authServices = authServices;
        }

    }
}
