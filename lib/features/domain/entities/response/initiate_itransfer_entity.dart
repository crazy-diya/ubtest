
import 'package:union_bank_mobile/features/domain/entities/response/saved_itransfer_payee_entity.dart';

import '../../../../utils/enums.dart';
import 'account_entity.dart';

class InitiateItransferEntity {
  FTType? fundTransferType;

  SavedItransferPayeeEntity? payTo;
  AccountEntity? accountEntity;
  final int? transactionCategoryId;
  String? transactionCategory;
  String? theme;
  String? amount;
  String? message;
  String? sendAnonymously;
  bool? sendAnonymouslyStatus;
  double? availableBalance;
  bool? isCDBAccount;
  String? dateAndTime;
  String? referenceId;
  String? link;
  String? receiverName;
  String? mobileNumber;
  String? email;
  String? ceftCode;
  String? errorMsg;

  InitiateItransferEntity({
    this.transactionCategoryId,
    this.fundTransferType,
    this.payTo,
    this.accountEntity,
    this.transactionCategory,
    this.theme,
    this.amount,
    this.message,
    this.sendAnonymously,
    this.sendAnonymouslyStatus,
    this.availableBalance,
    this.isCDBAccount,
    this.dateAndTime,
    this.referenceId,
    this.link,
    this.receiverName,
    this.mobileNumber,
    this.email,
    this.ceftCode,
    this.errorMsg,
  });
}
