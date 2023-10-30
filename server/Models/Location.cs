﻿using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace RedHouse_Server.Models
{
    public class Location
    {
        [Key]
        public int LocationId { get; set; }
        public string ? StreetAddress { get; set; }
        public string ? City { get; set; }
        public string ? Region { get; set; }
        public string?  PostalCode { get; set; }
        public string ? Country { get; set; }
        public double ? Latitude { get; set; }
        public double ? Longitude { get; set; }
    }
}
