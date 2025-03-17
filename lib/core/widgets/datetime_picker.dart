import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';

class MyDatePicker {
  MyDatePicker(this.context);

  late BuildContext context;


  Future<String> nepaliDate({
    NepaliDateTime? firstDate,
    NepaliDateTime? lastDate,
  }) async {
    NepaliDateTime nowDate = NepaliDateTime.now();
    NepaliDateTime? pickedDate = await picker.showMaterialDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: firstDate ?? NepaliDateTime(2000),
      lastDate: lastDate ?? NepaliDateTime(2090),
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: _customDatePickerTheme(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      return _formatNepaliDate(pickedDate);
    }
    return '';
  }

  Future<String> englishDate({
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    DateTime nowDate = DateTime.now();


    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2099),
      builder: (context, child) {
        return Theme(
          data: _customDatePickerTheme(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      return _formatEnglishDate(pickedDate);
    }
    return '';
  }


  ThemeData _customDatePickerTheme() {
    return ThemeData(
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        onPrimary: Colors.white,
        surface: Colors.grey.shade100,
        onSurface: Colors.black87,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
        ),
      ),
      dialogBackgroundColor: Colors.white,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  String _formatNepaliDate(NepaliDateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  String _formatEnglishDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}