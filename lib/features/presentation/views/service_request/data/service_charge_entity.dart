
class ServiceChargeEntity{
  int? serviceChargeNumOfLeaves10;
  int? serviceChargeNumOfLeaves20;
  int? serviceChargeStatement;
  int? deliveryCharge;
  int? deliveryChargeStatement;

  ServiceChargeEntity(
      {this.serviceChargeNumOfLeaves10,
      this.serviceChargeNumOfLeaves20,
      this.serviceChargeStatement,
      this.deliveryCharge,
      this.deliveryChargeStatement});
}