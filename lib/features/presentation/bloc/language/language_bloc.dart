import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../domain/entities/request/language_entity.dart';
import '../../../domain/usecases/language/save_language.dart';
import '../../../domain/usecases/language/set_language.dart';
import '../../../domain/usecases/usecase.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, BaseState<LanguageState>> {
  final SetPreferredLanguage? setPreferredLanguage;
  final SavePreferredLanguage? savePreferredLanguage;

  LanguageBloc({this.setPreferredLanguage, this.savePreferredLanguage})
      : super(InitialLanguageState()) {
    on<SetPreferredLanguageEvent>(_onSetPreferredLanguageEvent);
    on<SavePrefLanguageStateEvent>(_onSavePrefLanguageStateEvent);
  }

  Future<void> _onSetPreferredLanguageEvent(SetPreferredLanguageEvent event,
      Emitter<BaseState<LanguageState>> emit) async {
    emit(APILoadingState());
    final result = await setPreferredLanguage!(LanguageEntity(
      selectedDate: event.selectedDate,
      messageType: kLanguageRequestType,
      language: event.language,
    ));

    emit(
      result.fold(
        (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is SessionExpire) {
            return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }else {
            return SetPreferredLanguageFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
        (r) {
          return SetPreferredLanguageSuccessState();
        },
      ),
    );
  }

  Future<void> _onSavePrefLanguageStateEvent(SavePrefLanguageStateEvent event,
      Emitter<BaseState<LanguageState>> emit) async {
    final _result = await savePreferredLanguage!(NoParams());

    emit(_result.fold((l) {
                  return SavePrefLanguageFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
              }, (r) {
      return SavePrefLanguageSuccessState();
    }));
  }
}
