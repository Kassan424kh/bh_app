import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_circle_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    final bool _isShowMessage = Provider.of<MessageProvider>(context).isShowMessage;
    final int _messageStatus = Provider.of<MessageProvider>(context).messageShowStatus;
    final bool _showMessageOkButton = Provider.of<MessageProvider>(context).messageOkButton != null;
    final size = MediaQuery.of(context).size;
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
                alignment: Alignment.bottomCenter.add(_messageStatus < 100 && _isShowMessage ? Alignment(0, -0.07) : Alignment(0, 5)),
                child: MouseRegion(
                  onEnter: (event) {
                    Provider.of<MessageProvider>(context, listen: false).messageShowingPause = true;
                  },
                  onExit: (event) {
                    Provider.of<MessageProvider>(context, listen: false).messageShowingPause = false;
                  },
                  child: ClipRect(
                    child: Container(
                      height: 150,
                      width: 400,
                      constraints: BoxConstraints(maxWidth: 500),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                        border: Border.all(width: 1, color: _selectedTheme[ElementStylingParameters.headerTextColor], style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                            color: _selectedTheme[ElementStylingParameters.boxShadowColor],
                            offset: Offset(15, 20),
                            blurRadius: 50,
                          )
                        ],
                      ),
                      child: Stack(
                        overflow: Overflow.clip,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) => Container(
                                  margin: size.width > Styling.tabletSizeWidth ? null:  EdgeInsets.only(right: 30),
                                  constraints: BoxConstraints(maxHeight: 5, minWidth: constraints.maxWidth),
                                  decoration: BoxDecoration(
                                    color: (_selectedTheme[ElementStylingParameters.primaryColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.splashOpacity]),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
                                        curve: Curves.easeOutQuart,
                                        color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
                                        width: (constraints.maxWidth - 30) * _messageStatus / 100,
                                        height: 5,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: AnimatedAlign(
                              duration: Duration(milliseconds: (Styling.durationAnimation).round()),
                              curve: Curves.easeInOutCubic,
                              alignment: size.width > Styling.tabletSizeWidth?
                              Alignment.topCenter.add(Alignment(0, Provider.of<MessageProvider>(context, listen: false).messageShowingPause ? 0 : -2)):
                              Alignment.topRight.add(Alignment(0.070, -0.32)),
                              child: UICircleButton(
                                icon: Icons.close,
                                color: Colors.redAccent,
                                onClick: () {
                                  Provider.of<MessageProvider>(context, listen: false).closeMessage = true;
                                },
                                buttonSize: 30,
                                toolTipMessage: "Close Message",
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Provider.of<MessageProvider>(context).messageTexts,
                                style: TextStyle(color: _selectedTheme[ElementStylingParameters.primaryAccentColor], fontSize: 18),
                              ),
                            ),
                          ),
                          _showMessageOkButton
                              ? Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      height: 35,
                                      child: UIButton(
                                        onPressed: Provider.of<MessageProvider>(context, listen: false).messageOkButton,
                                        leftWidget: Icon(OMIcons.check),
                                        isActive: true,
                                        withoutLeftWidgetSpace: true,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
