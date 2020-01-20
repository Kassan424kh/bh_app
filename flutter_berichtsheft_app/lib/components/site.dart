import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';

class Site extends StatelessWidget {
  final List<Widget> children;
  final String title;

  Site({Key key, this.children, this.title = ""})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _siteWidgets = <Widget>[
      HeaderText(
        text: title,
        fontSize: 40,
        margin: EdgeInsets.only(bottom: title != "" ? 60 : 0),
      ),
    ];
    _siteWidgets.addAll(children);

    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        padding: EdgeInsets.only(left: 60, top: 60, bottom: children.length != 0 ? 60 : 0),
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _siteWidgets,
        ),
      ),
    );
  }
}
