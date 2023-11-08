namespace RedHouse_Server.Dtos.ContractDtos
{
    public class ContractDto
    {
        public int PropertyId { get; set; }
        public int LandlordId { get; set; }
        public int CustomerId { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public string Description { get; set; }
        public decimal Price { get; set; }
        public string ContractType { get; set; }
    }
}
