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
    final size = MediaQuery.of(context).size;
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return AnimatedContainer(
      duration: Duration(milliseconds: (Styling.durationAnimation / 4).round()),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _selectedTheme[ElementStylingParameters.primaryColor],
        boxShadow: [
          BoxShadow(
            color: _selectedTheme[ElementStylingParameters.primaryColor],
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
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
                      flex: size.width > Styling.phoneSize ? 1 : 2,
                      child: UIButton(
                        noBackgroundColor: true,
                        onPressed: () {
                          Provider.of<ReportsProvider>(context, listen: false).addReportToSelectingList(reportId);
                        },
                        paddingLeft: true,
                        paddingRight: false,
                        itemsAlignment: MainAxisAlignment.start,
                        leftWidget: Icon(
                          Icons.check_box,
                          color: _selectedTheme[isSelected ? ElementStylingParameters.headerTextColor : ElementStylingParameters.primaryAccentColor],
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: size.width > Styling.phoneSize ? 2 : 3,
                      child: UIButton(
                        noBackgroundColor: true,
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
                      flex: size.width > Styling.phoneSize ? 1 : 2,
                      child: UIButton(
                        noBackgroundColor: true,
                        onPressed: () {},
                        paddingLeft: false,
                        paddingRight: false,
                        itemsAlignment: MainAxisAlignment.start,
                        disableButtonEffects: true,
                        text: "⌇ " + hours,
                      ),
                    ),
                    size.width > Styling.phoneSize
                        ? Flexible(
                            fit: FlexFit.tight,
                            flex: 7,
                            child: UIButton(
                              noBackgroundColor: true,
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
                          )
                        : Container(),
                  ],
                ),
              );
            }),
          ),
          Container(
            child: size.width < Styling.phoneSize
                ? LayoutBuilder(builder: (context, constraints) {
                    return size.width < Styling.phoneSize
                        ? Row(
                            children: <Widget>[
                              Container(
                                width: constraints.maxWidth,
                                child: UIButton(
                                  noBackgroundColor: true,
                                  itemsAlignment: MainAxisAlignment.start,
                                  paddingLeft: true,
                                  paddingRight: false,
                                  onPressed: () {},
                                  text: Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(width: 40),
                                        Expanded(
                                          child: Text(
                                            reportText.substring(0, (reportText.length > 100 ? 90 : reportText.length)) +
                                                (reportText.length > 120 || "\n".allMatches(reportText).length > 1 ? " ..." : ""),
                                            maxLines: 1,
                                            style: TextStyle(
                                              height: 1.3,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13.5,
                                              color: _selectedTheme == Styling.lightTheme ? Colors.black.withOpacity(0.9) : Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container();
                  })
                : Container(),
          ),
        ],
      ),
    );
  }
}
