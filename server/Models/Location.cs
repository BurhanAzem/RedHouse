using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace BlueHouse_Server.Models
{
    public class Location
    {
        [Key]
        public int Id { get; set; }
        public string ? StreetAddress { get; set; }
        public string ? City { get; set; }
        public string ? Region { get; set; }
        public string?  PostalCode { get; set; }
        public string ? Country { get; set; }
        public string ? Latitude { get; set; }
        public string ? Longitude { get; set; }
    }
}
