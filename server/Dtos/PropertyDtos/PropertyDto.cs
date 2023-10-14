using BlueHouse_Server.Dtos.LocationDtos;
using BlueHouse_Server.Dtos.NeighborhoodDtos;
using BlueHouse_Server.Models;
using System.ComponentModel.DataAnnotations.Schema;

namespace BlueHouse_Server.Dtos.PropertyDtos
{
    public class PropertyDto
    {
        public string PropertyType { get; set; }
        public int UserId { get; set; }
        public LocationDto LocationDto { get; set; }
        public NeighborhoodDto NeighborhoodDto { get; set; }
        public int Price { get; set; }
        public int NumberOfBedRooms { get; set; }
        public int NumberOfBathRooms { get; set; }
        public float SquareMetersArea { get; set; }
        public string PropertyDescription { get; set; }
        public DateOnly BuiltYear { get; set; }
        public string View { get; set; }
        public DateTime AvailableOn { get; set; } = DateTime.Now;
        public string PropertyStatus { get; set; }
        public int? NumberOfUnits { get; set; } = 1;
        public int ParkingSpots { get; set; }
        public string ListingType { get; set; }
        public bool IsAvailableBasement { get; set; }
        public string ListingBy { get; set; } 
    }
}
