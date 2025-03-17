part of 'datetime_bloc.dart';

abstract class DatePickerEvent {}

class InitializeDatePicker extends DatePickerEvent {}

class UpdateFromDate extends DatePickerEvent {
  final String fromDate;

  UpdateFromDate(this.fromDate);
}

class UpdateToDate extends DatePickerEvent {
  final String toDate;

  UpdateToDate(this.toDate);
}