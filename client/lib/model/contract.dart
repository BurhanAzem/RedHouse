class Contract{
   String? Title;
   String? CustomerName;
   String? LandlordName;
   String? Description;
   int? PropertyId;
   DateTime? CreatedDate;
   double? Price;
   String? ContractType;
   String? ContractStatus;
   double? Earnings;
   bool? IsShouldPay;
  Contract(this.Title, this.CustomerName, this.LandlordName, this.Description,
           this.PropertyId, this.CreatedDate, this.Price, this.ContractType,
            this.ContractStatus, this.Earnings, this.IsShouldPay);
}