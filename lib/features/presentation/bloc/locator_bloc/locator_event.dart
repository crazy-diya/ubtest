
import '../../../domain/entities/response/locator_entity.dart';
import '../base_event.dart';


abstract class LocatorEvent extends BaseEvent {}

class GetLocatorEvent extends LocatorEvent {
  final LocatorEntity? locatorEntity;

  GetLocatorEvent({this.locatorEntity});
}



