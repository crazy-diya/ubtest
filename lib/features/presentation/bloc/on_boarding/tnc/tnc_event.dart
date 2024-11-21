import '../../base_event.dart';

abstract class TnCEvent extends BaseEvent {}

class GetTermsEvent extends TnCEvent {
  final String? termType;

  GetTermsEvent({this.termType});
}

class AcceptTermsEvent extends TnCEvent {
  final int? termId;
  final String? acceptedDate;
  final String termType;
  final String isMigrated; 

  AcceptTermsEvent({this.termId, this.acceptedDate,required this.termType,required this.isMigrated,});
}
