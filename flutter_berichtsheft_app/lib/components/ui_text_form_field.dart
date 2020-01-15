import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UITextFormField extends StatelessWidget {
  final String hintText;
  final int maxLines, maxLength;
  final bool obscureText;
  final bool borderBottom;
  final onChanged, onSaved, onEditingComplete, onTap, onFieldSubmitted;

  UITextFormField({
    Key key,
    this.hintText = "",
    this.maxLines = 1,
    this.maxLength = 100,
    this.obscureText = false,
    this.borderBottom = true,
    this.onChanged,
    this.onSaved,
    this.onEditingComplete,
    this.onTap,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    return Container(
      margin: EdgeInsets.only(bottom: borderBottom ? 15 : 0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: _selectedTheme[ElementStylingParameters.boxShadowColor],
            offset: Offset(15, 20),
            blurRadius: 50,
          )
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: _selectedTheme[ElementStylingParameters.inputHintTextColor],
        maxLength: maxLength,
        minLines: 1,
        maxLines: maxLines,
        style: TextStyle(fontSize: 15, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          hintStyle: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor], fontSize: 15),
          hoverColor: _selectedTheme[ElementStylingParameters.primaryAccentColor],
          filled: true,
          isDense: true,
          fillColor: _selectedTheme[ElementStylingParameters.primaryAccentColor],
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
