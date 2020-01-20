import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ReportListTile extends StatelessWidget {
  final String date, hours, reportText;
  final bool isSelected;

  ReportListTile({
    Key key,
    this.isSelected = false,
    this.date = "date",
    this.hours = "hours",
    this.reportText = "report text",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            UIButton(
              onPressed: () {},
              leftWidget: Icon(
                Icons.check_box,
                color: _selectedTheme[isSelected ? ElementStylingParameters.headerTextColor : ElementStylingParameters.primaryColor],
              ),
              hiddenText: true,
              text: "Select all",
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
            Align(
              alignment: Alignment.centerLeft,
              child: UIButton(
                onPressed: () {},
                leftWidget: Text(
                  "|",
                  style: TextStyle(
                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                  ),
                ),
                text: SizedBox(
                  width: 550,
                  child: Text(
                    reportText,
                    style: TextStyle(
                      color: _selectedTheme == Styling.lightTheme ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
