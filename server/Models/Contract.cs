using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace RedHouse_Server.Models
{
    public class Contract
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey(nameof(Property))]
        public int PropertyId { get; set; }
        [ForeignKey(nameof(User))]
        public int LandlordId { get; set; }
        [ForeignKey(nameof(User))]
        public int CustomerId { get; set; }
        public DateTime CreatedDate { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public string ContractType { get; set; }

    }
}
