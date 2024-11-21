import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';

abstract class DocumentVerificationState extends BaseState<DocumentVerificationState> {}

class InitialDocumentVerificationState extends DocumentVerificationState {}

class DocumentVerificationInformationLoadedState extends DocumentVerificationState {
  final WalletOnBoardingData? walletOnBoardingData;
  //
  DocumentVerificationInformationLoadedState({this.walletOnBoardingData});
}

class DocumentVerificationInformationSubmittedSuccessState extends DocumentVerificationState {
  final bool? isBackButtonClick;

  DocumentVerificationInformationSubmittedSuccessState({this.isBackButtonClick});
}

class DocumentVerificationInformationFailedState extends DocumentVerificationState {
  final String? message;

  DocumentVerificationInformationFailedState({this.message});
}

class DocumentVerificationAPIFailedState extends DocumentVerificationState{
  final String? message;

  DocumentVerificationAPIFailedState({this.message});
}

class DocumentVerificationAPISuccessState extends DocumentVerificationState{

}

