
import '../../../../data/models/responses/get_other_products_response.dart';
import '../../base_state.dart';

abstract class OtherProductsState extends BaseState<OtherProductsState> {}

class InitialOtherProductsState extends OtherProductsState {}

class OtherProductsLoadingState extends OtherProductsState {}

class GetOtherProductsLoadedState extends OtherProductsState {
  final List<OtherProductsData>? data;

  GetOtherProductsLoadedState({this.data});
}

class GetOtherProductsFailedState extends OtherProductsState {
  final String? message;

  GetOtherProductsFailedState({this.message});
}

class SubmitOtherProductSuccessState extends OtherProductsState {
  final String? message;

  SubmitOtherProductSuccessState({this.message});
}

class SubmitOtherProductFailedState extends OtherProductsState {
  final String? message;

  SubmitOtherProductFailedState({this.message});
}

class SaveOtherProductsSuccessState extends OtherProductsState {}

class SaveOtherProductsFailedState extends OtherProductsState {
  final String? message;

  SaveOtherProductsFailedState({this.message});
}

class SaveUserSuccessState extends OtherProductsState {}

class SaveUserFailedState extends OtherProductsState {
  final String? message;

  SaveUserFailedState({this.message});
}
