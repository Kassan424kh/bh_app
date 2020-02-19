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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: UIButton(
                      onPressed: () {
                        Provider.of<ReportsProvider>(context, listen: false).addReportToSelectingList(reportId);
                      },
                      itemsAlignment: MainAxisAlignment.start,
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
                            " all " + Provider.of<ReportsProvider>(context).listOfSelectedReportIds.length.toString(),
                            style: TextStyle(color: Colors.transparent),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: UIButton(
                      onPressed: () {},
                      itemsAlignment: MainAxisAlignment.start,
                      disableButtonEffects: true,
                      leftWidget: Text(
                        "|",
                        style: TextStyle(
                          color: _selectedTheme[ElementStylingParameters.headerTextColor],
                        ),
                      ),
                      text: date,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: UIButton(
                      onPressed: () {},
                      itemsAlignment: MainAxisAlignment.start,
                      disableButtonEffects: true,
                      leftWidget: Text(
                        "|",
                        style: TextStyle(
                          color: _selectedTheme[ElementStylingParameters.headerTextColor],
                        ),
                      ),
                      text: hours,
                    ),
                  ),
                  Expanded(
                    flex: 5,
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
                          maxLines: 1,
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
            );
          }),
        ),
      ],
    );
  }
}
