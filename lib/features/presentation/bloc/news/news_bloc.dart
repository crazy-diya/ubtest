import 'package:bloc/bloc.dart';
import 'package:union_bank_mobile/features/data/models/common/base_request.dart';
import 'package:union_bank_mobile/features/domain/usecases/news/get_bbc.dart';
import 'package:union_bank_mobile/features/domain/usecases/news/get_cnn.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc
    extends BaseBloc<NewsEvent, BaseState<NewsState>> {
  final GetCnn getCnn;
  final GetBbc getBbc;

  NewsBloc({
    required this.getCnn,
    required this.getBbc,
  }) : super(NewsInitial()) {
    on<GetBbcEvent>(_onGetBbcEvent);
    on<GetCnnEvent>(_onGetCnnEvent);
  }

  Future<void> _onGetBbcEvent(GetBbcEvent event,
      Emitter<BaseState<NewsState>> emit) async {
    emit(APILoadingState());
    final _result = await getBbc(BaseRequest());

    if (_result.isRight()) {
      emit(_result.fold(
            (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState( error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(  error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }
          else {
            return NewsBbcFailedState( message: ErrorHandler().mapFailureToMessage(l));
          }
        }
            ,(r) =>
            NewsBbcSuccessState(
              data: r.data.toString()),
      ));
    } else {
      emit(NewsBbcFailedState(
      ));
    }
  }

  Future<void> _onGetCnnEvent(GetCnnEvent event,
      Emitter<BaseState<NewsState>> emit) async {
    emit(APILoadingState());
    final _result = await getCnn(BaseRequest());

    if (_result.isRight()) {
      emit(_result.fold(
        (l) {
          if (l is AuthorizedFailure) {
            return AuthorizedFailureState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is SessionExpire) {
            return SessionExpireState(
                error: ErrorHandler().mapFailureToMessage(l) ?? "");
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          } else if (l is ServerFailure) {
            return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
          }
          else {
            return NewsCnnFailedState(
                message: ErrorHandler().mapFailureToMessage(l));
          }
        },
        (r) => NewsCnnSuccessState(
              data: r.data.toString()),
      ));
    } else {
      emit(NewsCnnFailedState(
      ));
    }
  }



}



