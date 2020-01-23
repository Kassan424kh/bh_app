import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class Site extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final String siteRoute;

  Site({
    Key key,
    this.children,
    this.title = "",
    this.siteRoute,
  })  : assert(children != null),
        super(key: key);

  @override
  _SiteState createState() => _SiteState();
}

class _SiteState extends State<Site> {
  GlobalKey _homeSiteGKey = GlobalKey();
  RenderBox _renderBoxOfTheSite;
  String openedSite = "/";

  _renderBox(_) {
    if (_homeSiteGKey.currentContext != null) {
      setState(() {
        _renderBoxOfTheSite = _homeSiteGKey.currentContext.findRenderObject();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
    Timer(Duration(milliseconds: 10), () {
      Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(false);
      if (widget.siteRoute == Provider.of<NavigateProvider>(context, listen: false).nowOpenedSite) {
        Provider.of<StylingProvider>(context, listen: false).updateHeightOfShowSitesCardComponent(_renderBoxOfTheSite.size.height);
      }
    });
  }

  @override
  void didUpdateWidget(Site oldWidget) {
    super.didUpdateWidget(oldWidget);

    Timer(Duration(milliseconds: 10), (){
      if (Provider.of<ReportsProvider>(context, listen: false).showReportsAfterLoad) Provider.of<StylingProvider>(context, listen: false).updateHeightOfShowSitesCardComponent(_renderBoxOfTheSite.size
          .height);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _siteWidgets = <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: HeaderText(
          text: widget.title,
          fontSize: 40,
          margin: EdgeInsets.only(bottom: widget.title != "" ? 60 : 0),
        ),
      ),
    ];
    _siteWidgets.addAll(widget.children);

    final double _showSitesCardComponentWidth = Provider.of<StylingProvider>(context, listen: false).showSitesCardComponentWidth;

    Timer(Duration(milliseconds: 10), () {});

    return Container(
      key: _homeSiteGKey,
      width: _showSitesCardComponentWidth,
      padding: EdgeInsets.only(left: 60, top: 60, bottom: widget.children.length != 0 ? 60 : 0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
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
