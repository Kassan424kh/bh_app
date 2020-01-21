import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/go_and_back_ui_buttons.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_date_picker.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateNewReport extends StatefulWidget {
  @override
  _CreateNewReportState createState() => _CreateNewReportState();
}

class _CreateNewReportState extends State<CreateNewReport> {
  DateTime _startReportDate = DateTime.now();
  DateTime _endReportDate = DateTime.now();
  DateTime _oneDayReportDate = DateTime.now();

  bool areMoreThenOneDay = false;

  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  GlobalKey _createNewReportSiteGKey = GlobalKey();

  _renderBox(_) {
    if (_createNewReportSiteGKey.currentContext != null) {
      final RenderBox renderBox = _createNewReportSiteGKey.currentContext.findRenderObject();
      Provider.of<StylingProvider>(context, listen: false).setShowSitesCardComponentData(
        renderBox.size,
        renderBox.localToGlobal(Offset.zero),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    List<int> _listOfReportsIds = [];
    for (var i = 0; i < 30; i++) _listOfReportsIds.add(i);
    Provider.of<ReportsProvider>(context, listen: false).setReportsIds(_listOfReportsIds);
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  void didUpdateWidget(CreateNewReport oldWidget) {
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

    return Site(
      title: "Create new report",
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 50),
                UIButton(
                  leftWidget: Text(areMoreThenOneDay ? "From Date" : "Day Date ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                  onPressed: () => UIDatePicker.d(context, _selectedTheme, areMoreThenOneDay ? _startReportDate : _oneDayReportDate, (DateTime newSelectedDate) {
                    if (!newSelectedDate.isAfter(DateTime.now()))
                      setState(() {
                        if (areMoreThenOneDay)
                          _startReportDate = newSelectedDate;
                        else
                          _oneDayReportDate = newSelectedDate;
                      });
                  }),
                  text: _dateFormat.format(areMoreThenOneDay ? _startReportDate : _oneDayReportDate),
                  isActive: true,
                ),
                areMoreThenOneDay ? SizedBox(width: 20) : Container(),
                areMoreThenOneDay
                    ? UIButton(
                        leftWidget: Text("To Date ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                        onPressed: () => UIDatePicker.d(context, _selectedTheme, _endReportDate, (DateTime newSelectedDate) {
                          if (!newSelectedDate.isAfter(DateTime.now()))
                            setState(() {
                              _endReportDate = newSelectedDate;
                            });
                        }),
                        text: _dateFormat.format(_endReportDate),
                        isActive: true,
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 200,
              margin: EdgeInsets.only(left: 50),
              child: SwitchListTile(
                activeColor: _selectedTheme[ElementStylingParameters.headerTextColor],
                  inactiveThumbColor: _selectedTheme[ElementStylingParameters.inputHintTextColor],
                  inactiveTrackColor: (_selectedTheme[ElementStylingParameters.inputHintTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
                  activeTrackColor: (_selectedTheme[ElementStylingParameters.headerTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
                  onChanged: (value) => setState(() => areMoreThenOneDay = value),
                  value: areMoreThenOneDay,
                  title: Text("Multi Days", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor]))),
            ),
            SizedBox(height: 20),
            UITextField(
              icon: Icon(Icons.access_time, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
              onChanged: (s) {},
              marginLeft: 50,
              hintText: "Work Hours",
            ),
            SizedBox(height: 20),
            UITextField(
              icon: Icon(Icons.short_text, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
              onChanged: (s) {},
              marginLeft: 50,
              hintText: "Report",
              maxLines: 10,
            ),
          ],
        ),
        SizedBox(height: 60),
        GoAndBackUiButtons()
      ],
    );
  }
}
