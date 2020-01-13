import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class UITextFormField extends StatelessWidget {
  final String hintText;
  final int maxLines, maxLength;
  final bool obscureText;

  UITextFormField({
    Key key,
    this.hintText = "",
    this.maxLines = 1,
    this.maxLength = 100,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Styling.lightTheme[Elements.boxShadow],
            offset: Offset(15, 15),
            blurRadius: 50,
          )
        ],
      ),
      child: TextFormField(
        maxLength: maxLength,
        minLines: 1,
        maxLines: maxLines,
        style: TextStyle(fontSize: 15),
        obscureText: obscureText,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          hintStyle: TextStyle(color: Styling.lightTheme[Elements.inputHintText], fontSize: 15),
          hoverColor: Styling.lightTheme[Elements.primaryAccent],
          filled: true,
          isDense: true,
          fillColor: Styling.lightTheme[Elements.primaryAccent],
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
