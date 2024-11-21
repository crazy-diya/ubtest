import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/promotion/promotion_event.dart';

import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../error/failures.dart';
import '../../../data/models/requests/promotion_share_request.dart';
import '../../../data/models/requests/promotions_request.dart';
import '../../../domain/usecases/promotion/get_promotions.dart';

import '../../../domain/usecases/promotion/promotion_share.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'promotion_state.dart';

class PromotionBloc
    extends BaseBloc<PromotionEvent, BaseState<PromotionState>> {
  final GetPromotions? getPromotions;
  final PromotionPdfShare? promotionPdfShare;

  PromotionBloc({
    this.getPromotions,
    this.promotionPdfShare,
  }) : super(InitialPromotionState()) {
    on<GetPromotionsEvent>(_onGetPromotionsEvent);
    on<PromotionShareEvent>(_onPromotionShareEvent);
  }

  Future<void> _onGetPromotionsEvent(
      GetPromotionsEvent event, Emitter<BaseState<PromotionState>> emit) async {
    emit(APILoadingState());
    final _result = await getPromotions!(PromotionsRequest(
        messageType: kGetPromotionsRequestType, isHome: event.isFromHome.toString(),fromDate: event.fromDate,toDate: event.toDate));

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
          return PromotionsFailedState(
            message: ErrorHandler().mapFailureToMessage(l));}},
        (r) => PromotionsSuccessState(promotions: r.data!.promotionList,category: r.data!.categories),
      ));
    } else {
      emit(PromotionsFailedState(
      ));
    }
  }

  Future<void> _onPromotionShareEvent(PromotionShareEvent event,
      Emitter<BaseState<PromotionState>> emit) async {
    emit(APILoadingState());
    final result = await promotionPdfShare!(
      PromotionShareRequest(
        promotionId: event.promotionId!,
        messageType: event.messageType!,
      ),
    );

    emit(result.fold((l) {
      if (l is AuthorizedFailure) {
        return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is SessionExpire) {
        return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ConnectionFailure) {
        return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      } else if (l is ServerFailure) {
        return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
      }else {
        return PromotionPdfShareFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      return PromotionPdfShareSuccessState(
        document: r.data!.document,
        shouldOpen: event.shouldOpen,
      );
    }));
  }
}
