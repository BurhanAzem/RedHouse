using System.ComponentModel.DataAnnotations;

namespace BlueHouse_Server.Dtos.AuthDtos
{
    public class RegisterDto
    {
        [Required]
        [StringLength(100)]
        [DataType(DataType.EmailAddress)]
        public string? Email { get; set; }

        [Required]
        public string? Name { get; set; }

        [Required]
        [StringLength(100, MinimumLength = 5)]
        [DataType(DataType.Password)]
        public string? Password { get; set; }

        [Required]
        public int PhoneNumber { get; set; }

        public string? ZipCode { get; set; }

        [Required]
        public string? UserRole { get; set; } 
    }
}
