using RedHouse_Server.Dtos.AuthDtos;
using RedHouse_Server.Dtos.PropertyDtos;
using RedHouse_Server.Services;
using Cooking_School.Core.ModelUsed;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace RedHouse_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PropertyController : ControllerBase
    {
        private IPropertyServices _propertyServices;

        public PropertyController(IPropertyServices propertyServices) 
        {
            _propertyServices = propertyServices;
        }


        [HttpPost("/properties")]
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
            // else if(result.StatusCode == System.Net.HttpStatusCode.OK)
            return Ok(result);

        }
    }
}



