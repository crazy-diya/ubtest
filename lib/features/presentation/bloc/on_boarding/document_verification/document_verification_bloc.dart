import 'dart:async';

// import 'package:fpdart/fpdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/document_verification_request.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/document_verification_api_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/document_verification/document_verification.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'document_verification_event.dart';
import 'document_verification_state.dart';

class DocumentVerificationBloc extends BaseBloc<DocumentVerificationEvent,
    BaseState<DocumentVerificationState>> {
  final LocalDataSource? appSharedData;
  final GetWalletOnBoardingData? getWalletOnBoardingData;
  final StoreWalletOnBoardingData? storeWalletOnBoardingData;
  final DocumentVerification? useCaseDocumentVerification;

  DocumentVerificationBloc({
    this.appSharedData,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.useCaseDocumentVerification,
  }) : super(InitialDocumentVerificationState()) {
    on<StoreDocumentVerificationInformationEvent>(
        _onStoreDocumentVerificationInformationEvent);
    on<SendDocumentVerificationInformationEvent>(
        _onSendDocumentVerificationInformationEvent);
    on<GetDocumentVerificationInformationEvent>(
        _onGetDocumentVerificationInformationEvent);
  }

  Future<void> _onStoreDocumentVerificationInformationEvent(
      StoreDocumentVerificationInformationEvent event,
      Emitter<BaseState<DocumentVerificationState>> emit) async {
    // Get the Wallet Data
    final result = await getWalletOnBoardingData!(
        const WalletParams(walletOnBoardingDataEntity: null));
    // Check if result is (right)
    if (result.isRight()) {
      // Set the New Values
      final WalletOnBoardingData walletOnBoardingData =
          result.getOrElse((l) => null)!;
      if (walletOnBoardingData.walletUserData!.documentVerificationRequest !=
          null) {
        walletOnBoardingData.walletUserData!.documentVerificationRequest!
            .selfie = event.documentVerificationRequest!.selfie;
        walletOnBoardingData.walletUserData!.documentVerificationRequest!
            .billingProof = event.documentVerificationRequest!.billingProof;
        walletOnBoardingData.walletUserData!.documentVerificationRequest!
            .icFront = event.documentVerificationRequest!.icFront;
        walletOnBoardingData.walletUserData!.documentVerificationRequest!
            .icBack = event.documentVerificationRequest!.icBack;
        walletOnBoardingData.walletUserData!.documentVerificationRequest!
            .proofType = event.documentVerificationRequest!.proofType;
      } else {
        final DocumentVerificationRequest documentVerificationRequest =
            DocumentVerificationRequest(
                selfie: event.documentVerificationRequest!.selfie,
                icFront: event.documentVerificationRequest!.icFront,
                icBack: event.documentVerificationRequest!.icBack,
                billingProof: event.documentVerificationRequest!.billingProof,
                proofType: event.documentVerificationRequest!.proofType);
        walletOnBoardingData.walletUserData!.documentVerificationRequest =
            documentVerificationRequest;
      }

      // Store the Wallet Data
      final savedResult = await storeWalletOnBoardingData!(Parameter(
          walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperValue: event.stepValue,
              stepperName: event.stepName,
              walletUserData: walletOnBoardingData.walletUserData)));
      final obj = savedResult.fold((l) => l, (r) => r);
      if (obj is Failure) {
        if (obj is AuthorizedFailure) {
       emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is ServerFailure) {
          emit (ServerFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
        }
        else {
        emit(DocumentVerificationInformationFailedState(
            message: "Failed to load data"));
      }
      } else {
        emit(DocumentVerificationInformationSubmittedSuccessState(
            isBackButtonClick: event.isBackButtonClick));
      }
    } else {
      emit(DocumentVerificationInformationFailedState(
          message: "Failed to load data"));
    }
  }

  Future<void> _onSendDocumentVerificationInformationEvent(
      SendDocumentVerificationInformationEvent event,
      Emitter<BaseState<DocumentVerificationState>> emit) async {
    emit(APILoadingState());
    List<ImageListEntity> dataSet = [];
    dataSet.add(ImageListEntity(
        name: 'SELFIE',
        image:event.selfie));
    dataSet.add(ImageListEntity(
          name: 'NIC_FRONT',
          image:event.icFront));
    dataSet.add(ImageListEntity(
        name: 'NIC_BACK',
        image:event.icBack));

    // if (event.proofType != null) {
    //   if (event.proofType == 'nic') {
    //     dataSet.add(ImageListEntity(
    //         name: 'NIC_FRONT',
    //         image: AppUtils.convertBase64(
    //             base64Encode(File(event.icFront!).readAsBytesSync()))));
    //     dataSet.add(ImageListEntity(
    //         name: 'NIC_BACK',
    //         image: AppUtils.convertBase64(
    //             base64Encode(File(event.icBack!).readAsBytesSync()))));
    //   } else if (event.proofType == 'driving') {
    //     dataSet.add(ImageListEntity(
    //         name: 'DRIVING_LICENSE',
    //         image: AppUtils.convertBase64(
    //             base64Encode(File(event.icFront!).readAsBytesSync()))));
    //   } else if (event.proofType == 'passport') {
    //     dataSet.add(ImageListEntity(
    //         name: 'PASSPORT',
    //         image: AppUtils.convertBase64(
    //             base64Encode(File(event.icFront!).readAsBytesSync()))));
    //   }
    // }

    // if (event.billingProof != null && event.billingProof!.isNotEmpty) {
    //   dataSet.add(ImageListEntity(
    //       name: 'BILLING_PROOF',
    //       image: AppUtils.convertBase64(
    //           base64Encode(File(event.billingProof!).readAsBytesSync()))));
    // }

    final result = await useCaseDocumentVerification!(
      DocumentVerificationApiRequestEntity(
        messageType: kDocumentVerificationRequestType,
        imageList: dataSet,
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
      }
      else {
        return DocumentVerificationAPIFailedState(
            message: ErrorHandler().mapFailureToMessage(l));
      }
    }, (r) {
      if(r.responseCode =="00"){
         return DocumentVerificationAPISuccessState();
      }else{
         return DocumentVerificationAPIFailedState(
            message: r.errorDescription);
      }
     
    }));
  }

  Future<void> _onGetDocumentVerificationInformationEvent(
      GetDocumentVerificationInformationEvent event,
      Emitter<BaseState<DocumentVerificationState>> emit) async {
    final result = await (getWalletOnBoardingData!(
            const WalletParams(walletOnBoardingDataEntity: null))
        as FutureOr<Either<Failure, WalletOnBoardingData>>);
    final obj = result.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is Failure) {
      if (obj is AuthorizedFailure) {
       emit(AuthorizedFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is SessionExpire) {
        emit(SessionExpireState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is ConnectionFailure) {
        emit(ConnectionFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      } else if (obj is ServerFailure) {
        emit (ServerFailureState(error: ErrorHandler().mapFailureToMessage(obj)??""));
      }
      else {
       emit(DocumentVerificationInformationFailedState(
          message: "Failed to load data"));
      }
    } else {
      emit(DocumentVerificationInformationLoadedState(
          walletOnBoardingData: obj as WalletOnBoardingData?));
    }
  }
}
