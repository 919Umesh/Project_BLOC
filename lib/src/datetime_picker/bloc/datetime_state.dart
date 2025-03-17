part of 'datetime_bloc.dart';

class DatePickerState {
  final String fromDate;
  final String toDate;

  DatePickerState({
    required this.fromDate,
    required this.toDate,
  });

  DatePickerState copyWith({
    String? fromDate,
    String? toDate,
  }) {
    return DatePickerState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}