import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:provider/provider.dart';

class Site extends StatelessWidget {
  final List<Widget> children;
  final String title;

  Site({Key key, this.children, this.title = ""})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _siteWidgets = <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: HeaderText(
          text: title,
          fontSize: 40,
          margin: EdgeInsets.only(bottom: title != "" ? 60 : 0),
        ),
      ),
    ];
    _siteWidgets.addAll(children);

    final _showSitesCardComponentSize = Provider.of<StylingProvider>(context).showSitesCardComponentSize;

    return Container(
      width: _showSitesCardComponentSize!= Size(0,0)?  _showSitesCardComponentSize.width - 60 : null,
      padding: EdgeInsets.only(left: 60, top: 60, bottom: children.length != 0 ? 60 : 0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _siteWidgets,
          ),
        ],
      ),
    );
  }
}
