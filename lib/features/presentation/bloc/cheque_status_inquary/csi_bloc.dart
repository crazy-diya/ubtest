import 'package:bloc/bloc.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../data/models/requests/csi_request.dart';
import '../../../data/models/responses/csi_response.dart';
import '../../../domain/usecases/cheque_status_inquary/cheque_status_inquary.dart';
import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';


part 'csi_state.dart';
part 'csi_event.dart';

class CSIBloc
    extends BaseBloc<CSIEvent, BaseState<CSIState>> {
  final ChequeStatusInquiry? chequeStatusInquiry;

  CSIBloc({this.chequeStatusInquiry}) : super(CSIStateInitial()) {
    on<CSISuccessEvent>(_onCSIEvent);
  }

  Future<void> _onCSIEvent(CSISuccessEvent event,
      Emitter<BaseState<CSIState>> emit) async {
      emit(APILoadingState());
      final _result = await chequeStatusInquiry!(
        CsiRequest(
          accountType: event.accountType,
          accountNo: event.accountNo,
          checkAllAccount: event.checkAllAccount,
          fromDate: event.fromDate,
          toDate: event.toDate,
        ),
      );

      emit(_result.fold((l) {
         if (l is AuthorizedFailure) {
          return AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is SessionExpire) {
          return SessionExpireState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ConnectionFailure) {
          return ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
        } else if (l is ServerFailure) {
           return ServerFailureState(error: ErrorHandler().mapFailureToMessage(l)??"");
         }
         else {
          return CSIFailState(
              responseCode: ErrorHandler().mapFailureToMessage(l));
        }
      }, (r) {
        return CSISuccessState(
          csiDataList: r.data!.csiDataList
        );
      }));

  }
}