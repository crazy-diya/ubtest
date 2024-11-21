part of 'calculator_pdf_bloc.dart';

@immutable
abstract class CalculatorPDFEvent extends BaseEvent {}

// ignore: must_be_immutable
class CalculatorPDFDataEvent extends CalculatorPDFEvent {
  final String? title;
  List<DocBody>? docBody;
  final bool? shouldOpen;

  CalculatorPDFDataEvent({this.title, this.docBody, this.shouldOpen});
}