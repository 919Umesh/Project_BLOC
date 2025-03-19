import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
part 'datetime_event.dart';
part 'datetime_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerState(fromDate: '', toDate: '')) {
    on<InitializeDatePicker>((event, emit) async {
      final now = NepaliDateTime.now();
      final fromDate = DateTime(now.year, now.month, now.day - 30).toString().substring(0, 10);
      final toDate = now.toString().substring(0, 10);
      emit(state.copyWith(fromDate: fromDate, toDate: toDate));
    });

    on<UpdateFromDate>((event, emit) {
      emit(state.copyWith(fromDate: event.fromDate));
    });

    on<UpdateToDate>((event, emit) {
      emit(state.copyWith(toDate: event.toDate));
    });
  }

}