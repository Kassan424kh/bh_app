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

class _SiteState extends State<Site> with SingleTickerProviderStateMixin {
  GlobalKey _homeSiteGKey = GlobalKey();
  RenderBox _renderBoxOfTheSite;
  String openedSite = "/";

  AnimationController _animationController;
  Animation _showSiteOpacity;
  Animation _showSitePosition;

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

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (Styling.durationAnimation).round()),
    );
    _showSiteOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ))
      ..addListener(() {
        setState(() {});
      });
    _showSitePosition = Tween(begin: -500.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(Site oldWidget) {
    super.didUpdateWidget(oldWidget);

    Timer(Duration(milliseconds: 10), () {
      try {
        if (Provider.of<ReportsProvider>(context, listen: false).showReportsAfterLoad)
          Provider.of<StylingProvider>(context, listen: false).updateHeightOfShowSitesCardComponent(_renderBoxOfTheSite.size.height);
      } catch (e) {
        //print(e);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<LoginProvider>(context).isLoggedIn) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

    return Positioned(
      right: _showSitePosition.value,
      child: Opacity(
        opacity: _showSiteOpacity.value,
        child: Container(
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
        ),
      ),
    );
  }
}
