using System;

namespace server.Dtos.PropertyDtos
{
    public class FilterDto
    {
        public List<string> PropertyTypes { get; set; }
        public int MinPrice { get; set; }
        public int MaxPrice { get; set; }
        public int NumberOfBedRooms { get; set; }
        public int NumberOfBathRooms { get; set; }
        // public float SquareMeter { get; set; }
        // public DateTime BuiltYear { get; set; }
        public string View { get; set; }
        // public DateTime AvailableOn { get; set; } = DateTime.Now;
        // public string PropertyStatus { get; set; }
        // public int? NumberOfUnits { get; set; } = 1;
        // public int ParkingSpots { get; set; }
        public string ListingType { get; set; }
        // public string IsAvailableBasement { get; set; }
        public string ListingBy { get; set; } 
    }
}
