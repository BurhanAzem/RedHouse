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
        public Property Property { get; set; }

        [ForeignKey(nameof(User))]
        public int LandlordId { get; set; }
        public User Landlord { get; set; }

        [ForeignKey(nameof(User))]
        public int CustomerId { get; set; }
        public User Customer { get; set; }        
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public string Description { get; set; }
        public double Price { get; set; }
        public string ContractType { get; set; }
        public string ContractStatus { get; set; }
        public double Earnings { get; set; }
        public int IsShouldPay { get; set; }

    }
}
