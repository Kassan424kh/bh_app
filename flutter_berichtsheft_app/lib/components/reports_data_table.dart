import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/null_image.dart';
import 'package:flutter_berichtsheft_app/components/report_list_tile.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ReportsDataTable extends StatelessWidget {
  final listOfReports;
  final nullSiteIcon;

  ReportsDataTable({
    Key key,
    this.listOfReports,
    this.nullSiteIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    final List<int> _listOfSelectedReports = Provider.of<ReportsProvider>(context).listOfSelectedReportIds;
    return Column(children: <Widget>[
      Container(
        height: 50,
        color: _selectedTheme[ElementStylingParameters.primaryColor],
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: UIButton(
                    isActive: true,
                    onPressed: () {
                      List<int> _listOfReportsIds = [];
                      for (var i = 0; i < listOfReports.length; i++) _listOfReportsIds.add(listOfReports[i]["r_id"]);
                      Provider.of<ReportsProvider>(context, listen: false).selectAllReports(_listOfReportsIds);
                    },
                    itemsAlignment: MainAxisAlignment.start,
                    leftWidget: Icon(
                      Icons.check_box,
                      color: _selectedTheme[Provider.of<ReportsProvider>(context).areAllReportsSelected ? ElementStylingParameters.primaryAccentColor : Provider.of<ReportsProvider>(context)
                          .listOfSelectedReportIds.length != 0 ?  ElementStylingParameters.headerTextColor : ElementStylingParameters.primaryAccentColor],
                    ),
                    text: "Select all " + _listOfSelectedReports.length.toString(),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: UIButton(
                    isActive: true,
                    disableButtonEffects: true,
                    onPressed: () {},
                    itemsAlignment: MainAxisAlignment.start,
                    leftWidget: Text(
                      "|",
                      style: TextStyle(
                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                      ),
                    ),
                    text: "Date",
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: UIButton(
                    isActive: true,
                    disableButtonEffects: true,
                    onPressed: () {},
                    itemsAlignment: MainAxisAlignment.start,
                    leftWidget: Text(
                      "|",
                      style: TextStyle(
                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                      ),
                    ),
                    text: "Hours",
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: UIButton(
                    isActive: true,
                    disableButtonEffects: true,
                    onPressed: () {},
                    itemsAlignment: MainAxisAlignment.start,
                    leftWidget: Text(
                      "|",
                      style: TextStyle(
                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                      ),
                    ),
                    text: "Report text",
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      SizedBox(height: 20),
      AnimatedCrossFade(
        duration: Duration(milliseconds: (Styling.durationAnimation / 4).round()),
        firstCurve: Curves.easeOutCubic,
        secondCurve: Curves.easeOutCubic,
        firstChild: AnimatedContainer(
          duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
          curve: Curves.easeOutCubic,
          constraints: BoxConstraints(maxHeight: Provider.of<ReportsProvider>(context).showReportsAfterLoad ? (listOfReports.length * 60 > 600 ? 600 : listOfReports.length * 60).toDouble() : 0),
          child: Provider.of<ReportsProvider>(context).showReportsAfterLoad
              ? Scrollbar(
                  child: ListView.builder(
                    itemCount: listOfReports.length,
                    cacheExtent: 10,
                    itemExtent: 60,
                    reverse: true,
                    addAutomaticKeepAlives: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, int index) => ReportListTile(
                        reportId: listOfReports[index]["r_id"],
                        isSelected: Provider.of<ReportsProvider>(context).listOfSelectedReportIds.contains(listOfReports[index]["r_id"]) ? true : false,
                        date: listOfReports[index]["date"],
                        hours: listOfReports[index]["hours"].toString(),
                        reportText: listOfReports[index]["text"]),
                  ),
                )
              : Container(),
        ),
        secondChild: NullImage(
          image: _selectedTheme[nullSiteIcon],
        ),
        crossFadeState: listOfReports.length > 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    ]);
  }
}
