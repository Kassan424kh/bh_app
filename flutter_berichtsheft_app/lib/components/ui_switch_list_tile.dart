import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UISwitchListTile extends StatelessWidget {
  final bool value;
  final onChanged;
  final String text;
  final double width;

  UISwitchListTile({
    Key key,
    this.onChanged,
    this.value,
    this.text = "Multi Days",
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      height: 50,
      width: width,
      margin: EdgeInsets.only(left: 50),
      child: SwitchListTile(
          activeColor: _selectedTheme[ElementStylingParameters.headerTextColor],
          inactiveThumbColor: _selectedTheme[ElementStylingParameters.inputHintTextColor],
          inactiveTrackColor: (_selectedTheme[ElementStylingParameters.inputHintTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
          activeTrackColor: (_selectedTheme[ElementStylingParameters.headerTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
          onChanged: onChanged,
          value: value,
          title: Text(text, style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor]))),
    );
  }
}
