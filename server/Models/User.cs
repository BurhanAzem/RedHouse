using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.OpenApi.Any;
namespace BlueHouse_Server.Models
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Email { get; set; }
        public bool IsVerified { get; set; }  
        public int PhoneNumber { get; set; }
        [ForeignKey(nameof(Location))]
        public int LocationId { get; set; }
        public string? UserRole { get; set; }
    }
}
