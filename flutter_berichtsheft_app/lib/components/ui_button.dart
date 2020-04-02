import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UIButton extends StatelessWidget {
  final text;
  final Widget leftWidget;
  final bool isActive, hiddenText, withoutLeftWidgetSpace, disableButtonEffects, paddingLeft, paddingRight, noBackgroundColor;
  final onPressed, onLongPress;
  final Color textColor;
  final MainAxisAlignment itemsAlignment;

  UIButton({
    Key key,
    this.text,
    this.leftWidget,
    this.onPressed,
    this.isActive = false,
    this.hiddenText = false,
    this.disableButtonEffects = false,
    this.withoutLeftWidgetSpace = false,
    this.paddingLeft = true,
    this.paddingRight = true,
    this.textColor,
    this.onLongPress,
    this.itemsAlignment = MainAxisAlignment.center,
    this.noBackgroundColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      constraints: BoxConstraints(minHeight: 50),
      width: text == null && leftWidget != null && withoutLeftWidgetSpace ? 60 : null,
      color: !noBackgroundColor ? _selectedTheme[isActive ? ElementStylingParameters.primaryColor : ElementStylingParameters.primaryAccentColor] : Colors.transparent,
      child: FlatButton(
        color: Colors.transparent,
        textColor: _selectedTheme[ElementStylingParameters.headerTextColor],
        onPressed: onPressed,
        onLongPress: onLongPress,
        splashColor: disableButtonEffects ? Colors.transparent : null,
        highlightColor: disableButtonEffects ? Colors.transparent : null,
        hoverColor: Colors.transparent,
        padding: EdgeInsets.only(
          right: text == null && leftWidget != null && withoutLeftWidgetSpace ? 0 : paddingRight ? 20 : 0,
          left: text == null && leftWidget != null && withoutLeftWidgetSpace ? 0 : paddingLeft ? 20 : 0,
        ),
        child: Row(
          mainAxisAlignment: itemsAlignment,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            leftWidget != null ? leftWidget : Container(),
            (paddingLeft && text != null) && leftWidget != null ? SizedBox(width: 10) : Container(),
            text != null
                ? text is String
                    ? Text(
                        text,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: hiddenText ? Colors.transparent : null),
                      )
                    : text
                : Container(),
          ],
        ),
      ),
    );
  }
}
