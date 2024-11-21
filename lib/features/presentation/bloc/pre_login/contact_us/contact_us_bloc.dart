import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/error/failures.dart';

import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../domain/entities/request/contact_us_request_entity.dart';
import '../../../../domain/usecases/contact_us/contact_us.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsBloc
    extends BaseBloc<ContactUsParentEvent, BaseState<ContactUsState>> {
  final ContactUs? contactUs;

  ContactUsBloc({this.contactUs}) : super(InitialContactUsState()) {
    on<ContactUsEvent>(_onContactUsEvent);
  }

  Future<void> _onContactUsEvent(
      ContactUsEvent event, Emitter<BaseState<ContactUsState>> emit) async {
    emit(APILoadingState());
    final _result = await contactUs!(const ContactUsRequestEntity(
      messageType: kContactUsRequestType,
    ));

    if (_result.isRight()) {
      emit(_result.fold(
          (l)  {
            if (l is AuthorizedFailure) {
              return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is SessionExpire) {
              return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is ConnectionFailure) {
              return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            } else if (l is ServerFailure) {
              return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
            }else {
            return ContactUsFailedState(
              message: ErrorHandler().mapFailureToMessage(l));}},
          (r) => ContactUsSuccessState(

                contactUsDetails: r.data!.contactUsDetails,
              )));
    } else {
      emit(ContactUsFailedState(
      ));
    }
  }
}
