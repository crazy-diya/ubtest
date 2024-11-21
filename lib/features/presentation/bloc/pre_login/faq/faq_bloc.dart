
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../data/models/requests/faq_request.dart';
import '../../../../domain/usecases/faq/faq.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'faq_event.dart';
import 'faq_state.dart';

class FaqBloc extends BaseBloc<FaqEvent, BaseState<FaqState>> {
  final Faq? faq;

  FaqBloc({
    this.faq,
  }) : super(InitialFaqState()) {
    on<GetFaqEvent>(_onGetFaqEvent);
  }

  Future<void> _onGetFaqEvent(
      GetFaqEvent event, Emitter<BaseState<FaqState>> emit) async {
    emit(APILoadingState());

    final response = await faq!(
      FaqRequest(
        messageType: kFaqRequestType,
      ),
    );
    emit(response.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return FaqFailState(
            errorMessage: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return FaqSuccessState(
          faqData: r.data!.faqList, publicLink: r.data!.moreInfoUrl);
    }));
  }
}
