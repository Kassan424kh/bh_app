import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/reports_data_table.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_date_picker.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  API _api;
  List<dynamic> _listOfFoundReports = [];

  bool _isUpdated = false;
  int _updatingTime = 0;

  _setListOfReportsIds(list) {
    try {
      Provider.of<ReportsProvider>(context, listen: false).setReportsIds(list);
    } catch (e) {}
  }

  _getReports() {
    List<dynamic> foundReports =
        Provider.of<ReportsProvider>(context).listOfFoundReports;
    print(foundReports);
    setState(() {
      _isUpdated = false;
      _updatingTime = 0;
      _listOfFoundReports.clear();
      _listOfFoundReports.addAll(foundReports);
    });

    List<int> _listOfReportsIds = [];
    for (var i = 0; i < foundReports.length; i++)
      _listOfReportsIds.add(foundReports[i]["r_id"]);
    _setListOfReportsIds(_listOfReportsIds);
  }

  @override
  void initState() {
    super.initState();
    _api = API(context: context);
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
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;

    return Site(
      siteRoute: "/search",
      title: "Search",
      children: <Widget>[
        Container(
          height: 50,
          child: ListView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              // search button field to selected date
              UIButton(
                leftWidget: Text("To",
                    style: TextStyle(
                        color: _selectedTheme[
                            ElementStylingParameters.inputHintTextColor])),
                onPressed: () =>
                    UIDatePicker.d(context, _selectedTheme, _toDate,
                        (DateTime newSelectedDate) {
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
              SizedBox(width: 20),

// search button field from selected date
              UIButton(
                leftWidget: Text("From",
                    style: TextStyle(
                        color: _selectedTheme[
                            ElementStylingParameters.inputHintTextColor])),
                onPressed: () =>
                    UIDatePicker.d(context, _selectedTheme, _fromDate,
                        (DateTime newSelectedDate) {
                  if (newSelectedDate != null &&
                      newSelectedDate != _fromDate &&
                      newSelectedDate.isBefore(_toDate))
                    setState(() {
                      _fromDate = newSelectedDate;
                    });
                }),
                text: _dateFormat.format(_fromDate),
                hiddenText: _dateFormat.format(_fromDate) ==
                    _dateFormat.format(DateTime.now()),
                isActive: true,
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
              // delete reports button
              UIButton(
                onPressed: () {
                  bool areReportsSelected =
                      Provider.of<ReportsProvider>(context, listen: false)
                              .listOfSelectedReportIds
                              .length >
                          0;
                  Provider.of<MessageProvider>(context, listen: false)
                      .showMessage(
                    true,
                    messageText: areReportsSelected
                        ? "Are you sure, you want to delete selected reports?"
                        : "There are no selected reports",
                    okButton: areReportsSelected
                        ? () {
                            List<int> _listOfSelectedReportIds =
                                Provider.of<ReportsProvider>(context,
                                        listen: false)
                                    .listOfSelectedReportIds;
                            _api
                                .deleteReports(_listOfSelectedReportIds)
                                .then((permanentlyDeleted) {
                              if (permanentlyDeleted) {
                                _listOfFoundReports.removeWhere((report) =>
                                    _listOfSelectedReportIds
                                        .contains(report["r_id"]));
                                Provider.of<ReportsProvider>(context,
                                        listen: false)
                                    .clearSelectedReports();
                              }
                            });
                          }
                        : null,
                  );
                },
                leftWidget: Icon(Icons.delete_outline),
                isActive: true,
                withoutLeftWidgetSpace: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ReportsDataTable(
          listOfReports:
              Provider.of<ReportsProvider>(context).listOfFoundReports,
          nullSiteIcon: SitesIcons.nullFoundReports,
        )
      ],
    );
  }
}
