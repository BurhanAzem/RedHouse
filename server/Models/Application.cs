using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace RedHouse_Server.Models
{
    public class Application
    {
        [Key]
        public int ApplicationId { get; set; }
        [ForeignKey(nameof(Property))]
        public int PropertyId { get; set; }

        [ForeignKey(nameof(User))]
        public int CustomerId { get; set; }
        public DateTime ApplicationDate { get; set; }
        public string Message { get; set; }
        public string Status { get; set; }

    }
}
