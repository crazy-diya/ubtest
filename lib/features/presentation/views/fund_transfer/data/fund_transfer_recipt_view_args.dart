import '../../../../domain/entities/response/fund_transfer_entity.dart';

class FundTransferReceiptViewArgs{
  final bool? paymentSuccess;
  final String? message;
  final FundTransferEntity fundTransferEntity;

  FundTransferReceiptViewArgs({ this.paymentSuccess,  this.message,required this.fundTransferEntity});
}