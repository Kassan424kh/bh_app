import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/report_list_tile.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_date_picker.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  GlobalKey _homeSiteGKey = GlobalKey();

  _renderBox(_) {
    if (_homeSiteGKey.currentContext != null) {
      final RenderBox renderBox = _homeSiteGKey.currentContext.findRenderObject();
      Provider.of<StylingProvider>(context, listen: false).setShowSitesCardComponentData(
        renderBox.size,
        renderBox.localToGlobal(Offset.zero),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    final _showSitesCardComponentSize = Provider.of<StylingProvider>(context).showSitesCardComponentSize;

    return Site(
      key: _homeSiteGKey,
      title: "Home",
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Delete reports button
            UIButton(
              onPressed: () {},
              leftWidget: Icon(Icons.delete_outline),
              isActive: true,
              withoutLeftWidgetSpace: true,
            ),
            SizedBox(width: 20),

            // print reports button
            UIButton(
              onPressed: () {},
              leftWidget: Icon(Icons.print),
              isActive: true,
              withoutLeftWidgetSpace: true,
            ),
            SizedBox(width: 20),

            // search button field from selected date
            UIButton(
              leftWidget: Text("From", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
              onPressed: () => UIDatePicker.d(context, _selectedTheme, _fromDate, (DateTime newSelectedDate) {
                if (newSelectedDate != null && newSelectedDate != _fromDate && newSelectedDate.isBefore(_toDate))
                  setState(() {
                    _fromDate = newSelectedDate;
                  });
              }),
              text: _dateFormat.format(_fromDate),
              hiddenText: _dateFormat.format(_fromDate) == _dateFormat.format(DateTime.now()),
              isActive: true,
            ),
            SizedBox(width: 20),

            // search button field to selected date
            UIButton(
              leftWidget: Text("To", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
              onPressed: () => UIDatePicker.d(context, _selectedTheme, _toDate, (DateTime newSelectedDate) {
                if (newSelectedDate != null && newSelectedDate != _toDate)
                  setState(() {
                    _toDate = newSelectedDate;
                  });
                if (newSelectedDate.isBefore(_fromDate))
                  setState(() {
                    _fromDate = _toDate;
                  });
              }),
              text: _dateFormat.format(_toDate),
              isActive: true,
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          color: _selectedTheme[ElementStylingParameters.primaryColor],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UIButton(
                isActive: true,
                onPressed: () {},
                leftWidget: Icon(
                  Icons.check_box,
                  color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
                ),
                text: "Select all",
              ),
              SizedBox(width: 20),
              UIButton(
                isActive: true,
                onPressed: () {},
                leftWidget: Text(
                  "|",
                  style: TextStyle(
                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                  ),
                ),
                text: "Date",
              ),
              SizedBox(width: 20),
              UIButton(
                isActive: true,
                onPressed: () {},
                leftWidget: Text(
                  "|",
                  style: TextStyle(
                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                  ),
                ),
                text: "Hours",
              ),
              SizedBox(width: 20),
              UIButton(
                isActive: true,
                onPressed: () {},
                leftWidget: Text(
                  "|",
                  style: TextStyle(
                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                  ),
                ),
                text: "Report text",
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            ReportListTile(reportText: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut  elitr, sed diam nonumy eirmod tempor invidunt ut "),
            ReportListTile(),
            ReportListTile(),
            ReportListTile(),
            ReportListTile(),
            ReportListTile(),
            ReportListTile(),
            ReportListTile(),
          ],
        ),
      ],
    );
  }
}
