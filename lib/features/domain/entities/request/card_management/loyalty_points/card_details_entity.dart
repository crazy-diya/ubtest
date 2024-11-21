import '../../../../../data/models/responses/card_management/card_list_response.dart';
import '../../credit_card_mngmt_request_entity.dart';

class CardDetailsEntity{
  CardResPrimaryCardDetail? selectedCardDetails;
  List<CardResPrimaryCardDetail> primaryCardDetailsList;
  CreditCardMngmtRequestEntity? tempSelectedCreditCard;
  CardDetailsEntity({
    required this.selectedCardDetails,
    required this.primaryCardDetailsList,
    required this.tempSelectedCreditCard,
  });

}