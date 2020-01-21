import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UIButton extends StatelessWidget {
  final text;
  final Widget leftWidget;
  final bool isActive, hiddenText, withoutLeftWidgetSpace, disableButtonEffects;
  final onPressed;
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
    this.textColor,
    this.itemsAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return AnimatedContainer(
      constraints: BoxConstraints(minHeight: 50),
      width: text == null && leftWidget != null && withoutLeftWidgetSpace ? 60 : null,
      duration: Duration(milliseconds: Styling.durationAnimation),
      curve: Curves.easeInOutCubic,
      color: _selectedTheme[isActive ? ElementStylingParameters.primaryColor : ElementStylingParameters.primaryAccentColor],
      child: FlatButton(
        color: Colors.transparent,
        textColor: _selectedTheme[ElementStylingParameters.headerTextColor],
        onPressed: onPressed,
        splashColor: disableButtonEffects ? Colors.transparent : null,
        highlightColor: disableButtonEffects ? Colors.transparent : null,
        padding: EdgeInsets.symmetric(horizontal: text == null && leftWidget != null && withoutLeftWidgetSpace ? 0 : 20),
        child: Row(
          mainAxisAlignment: itemsAlignment,
          children: <Widget>[
            leftWidget != null ? leftWidget : Container(),
            SizedBox(width: leftWidget != null && !withoutLeftWidgetSpace ? 10 : 0),
            text != null
                ? text is String
                    ? Text(
                        text,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
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
