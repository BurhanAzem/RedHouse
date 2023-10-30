using System;
using RedHouse_Server.Dtos.LocationDtos;
using RedHouse_Server.Dtos.PropertyDtos;

namespace server.Dtos.PropertyDtos
{
    public class FilterDto
    {
        public List<string>? PropertyTypes { get; set; }
        public string? MinPrice { get; set; }
        public string? MaxPrice { get; set; }
        public string? NumberOfBedRooms { get; set; }
        public string? NumberOfBathRooms { get; set; }

        public string? View { get; set; }

        public string? ListingType { get; set; }
        public LocationFilterDto? LocationDto { get; set; }
    }
}
