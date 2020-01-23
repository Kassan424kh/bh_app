import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ReportListTile extends StatelessWidget {
  final String date, hours, reportText;
  final bool isSelected;
  final int reportId;

  ReportListTile({
    Key key,
    this.isSelected = false,
    this.date = "date",
    this.hours = "hours",
    this.reportText = "report text",
    this.reportId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    final _showSitesCardComponentWidth = Provider.of<StylingProvider>(context).showSitesCardComponentWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: _showSitesCardComponentWidth,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UIButton(
                onPressed: () {
                  Provider.of<ReportsProvider>(context, listen: false).addReportToSelectingList(reportId);
                },
                leftWidget: Icon(
                  Icons.check_box,
                  color: _selectedTheme[isSelected ? ElementStylingParameters.headerTextColor : ElementStylingParameters.primaryColor],
                ),
                //hiddenText: true,
                text: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Select"),
                    Text(
                      " all " + Provider.of<ReportsProvider>(context).listOfSelectedReports.length.toString(),
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              UIButton(
                onPressed: () {

                },
                disableButtonEffects: true,
                leftWidget: Text(
                  "|",
                  style: TextStyle(
                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                  ),
                ),
                text: date,
              ),
              SizedBox(width: 20),
              UIButton(
                onPressed: () {},
                disableButtonEffects: true,
                leftWidget: Text(
                  "|",
                  style: TextStyle(
                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                  ),
                ),
                text: hours,
              ),
              SizedBox(width: 20),
              Expanded(
                child: UIButton(
                  itemsAlignment: MainAxisAlignment.start,
                  onPressed: () {},
                  leftWidget: Text(
                    "|",
                    style: TextStyle(
                      color: _selectedTheme[ElementStylingParameters.headerTextColor],
                    ),
                  ),
                  text: Expanded(
                    child: Text(
                      reportText.substring(0, (reportText.length > 120 ? 120 : reportText.length)) + (reportText.length > 120 ? " ..." : ""),
                      style: TextStyle(
                        height: 1.3,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        color: _selectedTheme == Styling.lightTheme ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
