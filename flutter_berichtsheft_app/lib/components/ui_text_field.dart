import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UITextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final onSubmitted;
  final onChanged;
  final int maxLines;
  final double marginLeft;

  UITextField({
    Key key,
    this.hintText,
    this.onSubmitted,
    this.icon,
    this.marginLeft = 20,
    this.onChanged,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      color: _selectedTheme[ElementStylingParameters.primaryColor],
      child: TextField(
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        maxLines: maxLines,
        style: TextStyle(color: _selectedTheme[ElementStylingParameters.headerTextColor]),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor]),
          filled: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          fillColor: _selectedTheme[ElementStylingParameters.primaryColor],
          icon: icon != null ? Container(
            padding: EdgeInsets.only(left: 20),
            child: icon,
          ): null,
        ),
      ),
    );
  }
}
