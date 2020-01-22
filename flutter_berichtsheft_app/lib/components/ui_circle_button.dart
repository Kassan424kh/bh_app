import 'package:flutter/material.dart';

class UICircleButton extends StatelessWidget {
  final Color color;
  final icon;
  final onClick;
  final String toolTipMessage;
  final double buttonSize;

  UICircleButton({
    Key key,
    this.color,
    this.icon,
    this.onClick,
    this.toolTipMessage = "",
    this.buttonSize = 51,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: toolTipMessage,
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: RaisedButton(
          elevation: 0,
          padding: EdgeInsets.all(0),
          hoverElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          focusElevation: 0,
          animationDuration: Duration(milliseconds: 350),
          color: color.withOpacity(.2),
          splashColor: color.withOpacity(.3),
          focusColor: Colors.transparent,
          textColor: Colors.transparent,
          highlightColor: Colors.transparent,
          disabledTextColor: Colors.transparent,
          disabledColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(buttonSize / 2)),
          ),
          onPressed: onClick,
          child: Icon(
            icon,
            color: color,
            size: buttonSize * 40 / 100,
          ),
        ),
      ),
    );
  }
}