using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using RedHouse_Server.Models;

namespace server.Models
{
    public class UserIdentity
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey(nameof(User))]
        public int UserId { get; set; }
        public DateTime RequestDate { get; set; }
        public bool RequestStatus { get; set; }
        public ICollection<IdentityFile>? IdentityFiles { get; set; }
        
    }
}
