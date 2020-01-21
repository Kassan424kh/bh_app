import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
    Provider.of<MessageProvider>(context, listen: false).showMessage(true);
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    final bool _isShowMessage = Provider.of<MessageProvider>(context).isShowMessage;
    final int _messageStatus = Provider.of<MessageProvider>(context).messageShowStatus;
    return _isShowMessage
        ? Positioned.fill(
            bottom: 0,
            left: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: (Styling.durationAnimation).round()),
              curve: Curves.easeInOutCubic,
              onEnd: () {
                Provider.of<MessageProvider>(context, listen: false).showMessage(false);
              },
              color: _messageStatus < 100 && _isShowMessage
                  ? (_selectedTheme[ElementStylingParameters.primaryAccentColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity])
                  : Colors.transparent,
              child: AnimatedAlign(
                duration: Duration(milliseconds: (Styling.durationAnimation).round()),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.bottomRight.add(_messageStatus < 100 && _isShowMessage ? Alignment(-0.05, -0.07) : Alignment(5, 5)),
                child: Container(
                  height: 150,
                  width: 300,
                  constraints: BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                      color: _selectedTheme[ElementStylingParameters.headerTextColor],
                      border: Border.all(width: 1, color: _selectedTheme[ElementStylingParameters.headerTextColor], style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: _selectedTheme[ElementStylingParameters.boxShadowColor],
                          offset: Offset(15, 20),
                          blurRadius: 50,
                        )
                      ]),
                  padding: EdgeInsets.all(10),
                  child: Text("This is a Message"),
                ),
              ),
            ),
          )
        : Container();
  }
}
