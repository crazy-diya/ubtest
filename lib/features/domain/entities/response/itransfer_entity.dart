import '../../../../utils/enums.dart';
import 'saved_itransfer_payee_entity.dart';

class ItransferEntity {

  final FTType? fundTransferType;

  SavedItransferPayeeEntity? payTo;
  String? theme;
  String? bankName;
  int? accountNumber;
  String? transactionCategory;
  String? amount;
  String? message;
  String? receiverName;
  String? mobileNumber;
  String? email;
  bool? sendAnonymously;
  String? date;
  String? time;
  String? referenceId;

  ItransferEntity({
    this.fundTransferType,
    this.payTo,
    this.theme,
    this.bankName,
    this.transactionCategory,
    this.amount,
    this.message,
    this.receiverName,
    this.mobileNumber,
    this.email,
    this.sendAnonymously,
    this.date,
    this.accountNumber,
    this.referenceId,
    this.time,
  });
}
