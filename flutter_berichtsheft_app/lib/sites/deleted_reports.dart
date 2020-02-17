import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/null_image.dart';
import 'package:flutter_berichtsheft_app/components/report_list_tile.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_date_picker.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DeletedReports extends StatefulWidget {
  @override
  _DeletedReportsState createState() => _DeletedReportsState();
}

class _DeletedReportsState extends State<DeletedReports> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  API _api;
  List<dynamic> _listOfDeletedReports = [];

  bool _isUpdated = false;
  int _updatingTime = 0;

  _setListOfReportsIds(list) {
    try {
      Provider.of<ReportsProvider>(context, listen: false).setReportsIds(list);
    } catch (e) {}
  }

  _getReports() {
    _api.deletedReports.then((reports) {
      setState(() {
        if (reports.length != _listOfDeletedReports.length) {
          _isUpdated = false;
          _updatingTime = 0;
        }
        _listOfDeletedReports.clear();
        _listOfDeletedReports = reports.length != 0 ? reports : [];
      });

      List<int> _listOfReportsIds = [];
      for (var i = 0; i < reports.length; i++) _listOfReportsIds.add(reports[i]["r_id"]);
      _setListOfReportsIds(_listOfReportsIds);
    });
  }

  @override
  void initState() {
    super.initState();
    _api = API(context: context);
    setState(() {
      _isUpdated = false;
      _updatingTime = 0;
      _listOfDeletedReports.clear();
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isUpdated && _updatingTime <= 2) {
      _getReports();
      setState(() {
        _isUpdated = true;
        _updatingTime++;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    final List<int> _listOfSelectedReports = Provider.of<ReportsProvider>(context).listOfSelectedReports;
    return Site(
      siteRoute: "/deleted-reports",
      title: "Deleted reports",
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Revert reports button
            UIButton(
              onPressed: () {
                _api.revertReports(Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports);
              },
              leftWidget: Icon(OMIcons.settingsBackupRestore),
              isActive: true,
              withoutLeftWidgetSpace: true,
            ),
            SizedBox(width: 20),

            // Permanently delete reports button
            UIButton(
              onPressed: () {
                bool areReportsSelected = Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports.length > 0;
                Provider.of<MessageProvider>(context, listen: false).showMessage(
                  true,
                  messageText: areReportsSelected ? "Are you sure, you want to delete selected reports permanently?" : "There are no selected reports",
                  okButton: areReportsSelected
                      ? () {
                          _api.deleteReports(Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports, permanently: true);
                        }
                      : null,
                );
              },
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
                onPressed: () {
                  List<int> _listOfReportsIds = [];
                  for (var i = 0; i < _listOfDeletedReports.length; i++) _listOfReportsIds.add(_listOfDeletedReports[i]["r_id"]);
                  Provider.of<ReportsProvider>(context, listen: false).selectAllReports(_listOfReportsIds);
                },
                leftWidget: Icon(
                  Icons.check_box,
                  color: _selectedTheme[Provider.of<ReportsProvider>(context).areAllReportsSelected ? ElementStylingParameters.primaryAccentColor : ElementStylingParameters.headerTextColor],
                ),
                text: "Select all " + _listOfSelectedReports.length.toString(),
              ),
              SizedBox(width: 20),
              UIButton(
                isActive: true,
                disableButtonEffects: true,
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
                disableButtonEffects: true,
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
                disableButtonEffects: true,
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
        AnimatedCrossFade(
          duration: Duration(milliseconds: (Styling.durationAnimation / 4).round()),
          firstCurve: Curves.easeOutCubic,
          secondCurve: Curves.easeOutCubic,
          firstChild: AnimatedContainer(
            duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
            curve: Curves.easeOutCubic,
            constraints: BoxConstraints(
                maxHeight: Provider.of<ReportsProvider>(context).showReportsAfterLoad ? (_listOfDeletedReports.length * 60 > 600 ? 600 : _listOfDeletedReports.length * 60).toDouble() : 0),
            child: Provider.of<ReportsProvider>(context).showReportsAfterLoad
                ? Scrollbar(
                    child: ListView.builder(
                      itemCount: _listOfDeletedReports.length,
                      cacheExtent: 10,
                      itemExtent: 60,
                      reverse: true,
                      addAutomaticKeepAlives: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, int index) => ReportListTile(
                          reportId: _listOfDeletedReports[index]["r_id"],
                          isSelected: Provider.of<ReportsProvider>(context).listOfSelectedReports.contains(_listOfDeletedReports[index]["r_id"]) ? true : false,
                          date: _listOfDeletedReports[index]["date"],
                          hours: _listOfDeletedReports[index]["hours"].toString(),
                          reportText: _listOfDeletedReports[index]["text"]),
                    ),
                  )
                : Container(),
          ),
          secondChild: NullImage(
            image: _selectedTheme[SitesIcons.nullDeletedReports],
          ),
          crossFadeState: _listOfDeletedReports.length > 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ],
    );
  }
}
