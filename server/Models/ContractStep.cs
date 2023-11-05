using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.Contracts;

namespace server.Models
{
    public class ContractStep
    {
        [Key]
        public int Id { get; set; }
        [ForeignKey(nameof(Contract))]
        public int ContractId { get; set; }
        public string StepType { get; set; }
        public DateTime StepDate { get; set; }
        public int StepBudget { get; set; }
    }
}
