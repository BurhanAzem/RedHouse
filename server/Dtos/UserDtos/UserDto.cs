using System;
using RedHouse_Server.Dtos.LocationDtos;

namespace server.Dtos.UserDtos
{
    public class UserDto
    {
        public string? Name { get; set; }
        public string? Email { get; set; }
        public bool? IsVerified { get; set; }
        public int? PhoneNumber { get; set; }
        public int? LandlordScore { get; set; }
        public int? CustomerScore { get; set; }
        public int? LocationId { get; set; }
        public LocationDto? Location { get; set; }
        public string? UserRole { get; set; }
    }
}
