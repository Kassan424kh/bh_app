import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class UIDatePicker extends DatePicker {
  static d(BuildContext context, selectedTheme, DateTime date, onConfirm, {DateTime maxDate}) {
    return DatePicker.showDatePicker(
      context,
      theme: DatePickerTheme(
        backgroundColor: selectedTheme[ElementStylingParameters.primaryColor],
        itemStyle: TextStyle(
          color: selectedTheme[ElementStylingParameters.headerTextColor],
        ),
        cancelStyle: TextStyle(
          color: selectedTheme[ElementStylingParameters.logoutButtonColor],
        ),
        doneStyle: TextStyle(
          color: selectedTheme[ElementStylingParameters.editButtonColor],
        ),
      ),
      showTitleActions: true,
      maxTime: maxDate == null ? DateTime.now(): maxDate,
      onConfirm: onConfirm,
      currentTime: date,
      locale: LocaleType.de,
    );
  }
}
