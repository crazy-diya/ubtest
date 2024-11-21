import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/quick_access/quick_access_event.dart';

import '../base_bloc.dart';
import '../base_state.dart';
import 'quick_access_state.dart';

class QuickAccessBloc extends BaseBloc<QuickAccessEvent, BaseState<QuickAccessState>> {
  final LocalDataSource? localDataSource;

  QuickAccessBloc({this.localDataSource}) : super(InitialQuickAccessState()) {
    on<AddQuickAccessEvent>(_onAddQuickAccessEvent);
    on<AddQuickAccessEventWhenPop>(_onAddQuickAccessWhenPopEvent);
    // on<RemoveQuickAccessEvent>(_onRemoveQuickAccessEvent);
    on<GetQuickAccessEvent>(_onGetQuickAccessEventEvent);
  }

  Future<void> _onAddQuickAccessEvent(
      AddQuickAccessEvent event,
      Emitter<BaseState<QuickAccessState>> emit) async {

    final isSave = await localDataSource?.setQuickAccess(event.ids!);
    if (isSave!) {
      final list = localDataSource?.getQuickAccessList();
      emit(QuickAccessAddSuccessState(quickAccessList: list));
    } else {
      emit(QuickAccessAddFailedState());
    }
  }

  Future<void> _onAddQuickAccessWhenPopEvent(
      AddQuickAccessEventWhenPop event,
      Emitter<BaseState<QuickAccessState>> emit) async {

    final isSave = await localDataSource?.setQuickAccess(event.ids!);
    if (isSave!) {
      final list = localDataSource?.getQuickAccessList();
      emit(QuickAccessAddSuccessStateWhenPop(quickAccessList: list));
    } else {
      emit(QuickAccessAddFailedStateWhenPop());
    }
  }

  //   Future<void> _onRemoveQuickAccessEvent(
  //     RemoveQuickAccessEvent event,
  //     Emitter<BaseState<QuickAccessState>> emit) async {

  //   final isSave = await localDataSource?.removeQuickAccess(event.id!);
  //   if (isSave!) {
  //     final list = localDataSource?.getQuickAccessList();
  //     emit(QuickAccessLoadSuccessState(quickAccessList: list));
  //   } else {
  //     emit(QuickAccessLoadFailedState());
  //   }
  // }

    Future<void> _onGetQuickAccessEventEvent(
      GetQuickAccessEvent event,
      Emitter<BaseState<QuickAccessState>> emit) async {

    final list = localDataSource?.getQuickAccessList();
    if (list != null) {
      emit(QuickAccessLoadSuccessState(quickAccessList: list));
    } else {
      emit(QuickAccessLoadFailedState());
    }
  }
}
