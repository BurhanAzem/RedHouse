using System.ComponentModel.DataAnnotations;

namespace RedHouse_Server.Models
{
    public class Neighborhood
    {
        [Key]
        public int Id { get; set; }
        public string NeighborhoodType { get; set; }
        public string NeighborhoodName { get; set; }

    }
}
