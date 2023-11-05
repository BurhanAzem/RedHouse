using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using RedHouse_Server.Models;

namespace server.Models
{
    public class UserHistory
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey(nameof(User))]

        public int CustomerId { get; set; }
        [ForeignKey(nameof(User))]

        public int LandlordId { get; set; }

        public DateTime TimeStamp { get; set; }

        public string Comment { get; set; }

        public int Rating { get; set; }
    }
}
