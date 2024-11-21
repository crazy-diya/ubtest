
import '../../../../data/models/requests/document_verification_request.dart';
import '../../base_event.dart';

abstract class DocumentVerificationEvent extends BaseEvent {}

/// Get Personal Information
class GetDocumentVerificationInformationEvent
    extends DocumentVerificationEvent {}

/// Store Personal Information
class StoreDocumentVerificationInformationEvent
    extends DocumentVerificationEvent {
  final int? stepValue;
  final String? stepName;
  final DocumentVerificationRequest? documentVerificationRequest;
  final bool? isBackButtonClick;

  StoreDocumentVerificationInformationEvent(
      {this.documentVerificationRequest,
      this.stepName,
      this.stepValue,
      this.isBackButtonClick});
}

/// Send Data to Server
class SendDocumentVerificationInformationEvent
    extends DocumentVerificationEvent {
  String? selfie;
  String? icFront;
  String? icBack;
  String? billingProof;
  String? proofType;
  

  SendDocumentVerificationInformationEvent(
      {this.selfie,
      this.icFront,
      this.icBack,
      this.billingProof,
      this.proofType});
}
