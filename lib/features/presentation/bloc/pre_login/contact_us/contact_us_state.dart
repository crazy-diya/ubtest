
import '../../../../data/models/responses/contact_us_response.dart';
import '../../base_state.dart';

abstract class ContactUsState extends BaseState<ContactUsState>{}

class InitialContactUsState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {
  final List<ContactUsDetail>? contactUsDetails;

  ContactUsSuccessState({this.contactUsDetails});

}

class ContactUsFailedState extends ContactUsState {
  final String? message;

  ContactUsFailedState({this.message});
}