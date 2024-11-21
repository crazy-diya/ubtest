

import '../../../data/models/requests/terms_acccept_request_model.dart';

class TermsAcceptRequestEntity extends TermsAcceptRequestModel {
  TermsAcceptRequestEntity({
    termId,
    acceptedDate,
    messageType,
    instrumentId,
    justpayInstrumentId,
    termType,
    isMigrated,
  }) : super(
            termId: termId,
            acceptedDate: acceptedDate,
            messageType: messageType,
            instrumentId: instrumentId,
      termType: termType,
            justpayInstrumentId:justpayInstrumentId,isMigrated: isMigrated);
}
