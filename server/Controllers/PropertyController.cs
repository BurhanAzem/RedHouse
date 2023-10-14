using BlueHouse_Server.Dtos.AuthDtos;
using BlueHouse_Server.Dtos.PropertyDtos;
using BlueHouse_Server.Services;
using Cooking_School.Core.ModelUsed;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BlueHouse_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PropertyController : ControllerBase
    {
        private IPropertyServices _propertyServices;

        PropertyController(IPropertyServices propertyServices) 
        {
            _propertyServices = propertyServices;
        }


        [HttpPost("/Properties")]
        public async Task<IActionResult> CreateProperty(PropertyDto propertyDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var result = await _propertyServices.AddProperty(propertyDto);
            if (result.Exception != null)
            {
                var code = result.StatusCode;
                throw new StatusCodeException(code.Value, result.Exception);
            }
            return Ok(result);

        }
    }
}
