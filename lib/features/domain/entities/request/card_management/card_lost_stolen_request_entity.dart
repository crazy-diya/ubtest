import 'package:union_bank_mobile/features/data/models/requests/card_management/card_lost_stolen_request.dart';

class CardLostStolenRequestEntity extends CardLostStolenRequest {
  final String? maskedCardNumber;
  final String? messageType;
  final String? reissueRequest;
  final String? branchCode;
  final bool? isBranch;

  CardLostStolenRequestEntity({
    this.maskedCardNumber,
    this.messageType,
    this.reissueRequest,
    this.branchCode,
    this.isBranch,
  }) : super(
          maskedCardNumber: maskedCardNumber,
          messageType: messageType,
          reissueRequest: reissueRequest,
    branchCode: branchCode,
    isBranch: isBranch,
        );
}
