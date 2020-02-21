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
                    child: UIButton(
                      onPressed: () {
                        Provider.of<ReportsProvider>(context, listen: false).addReportToSelectingList(reportId);
                      },
                      paddingLeft: true,
                      paddingRight: false,
                      itemsAlignment: MainAxisAlignment.start,
                      leftWidget: Icon(
                        Icons.check_box,
                        color: _selectedTheme[isSelected ? ElementStylingParameters.headerTextColor : ElementStylingParameters.primaryColor],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: UIButton(
                      onPressed: () {},
                      paddingLeft: true,
                      paddingRight: false,
                      itemsAlignment: MainAxisAlignment.start,
                      disableButtonEffects: true,
                      text: date,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: UIButton(
                      onPressed: () {},
                      paddingLeft: false,
                      paddingRight: false,
                      itemsAlignment: MainAxisAlignment.start,
                      disableButtonEffects: true,
                      text: "⌇ " + hours,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 7,
                    child: UIButton(
                      itemsAlignment: MainAxisAlignment.start,
                      paddingLeft: true,
                      paddingRight: false,
                      onPressed: () {},
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
