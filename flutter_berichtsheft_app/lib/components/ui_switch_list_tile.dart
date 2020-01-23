import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UISwitchListTile extends StatelessWidget {
  final bool value;
  final onChanged;

  UISwitchListTile({Key key, this.onChanged, this.value}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      height: 50,
      width: 200,
      margin: EdgeInsets.only(left: 50),
      child: SwitchListTile(
          activeColor: _selectedTheme[ElementStylingParameters.headerTextColor],
          inactiveThumbColor: _selectedTheme[ElementStylingParameters.inputHintTextColor],
          inactiveTrackColor: (_selectedTheme[ElementStylingParameters.inputHintTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
          activeTrackColor: (_selectedTheme[ElementStylingParameters.headerTextColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
          onChanged: onChanged,
          value: value,
          title: Text("Multi Days", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor]))),
    );
  }
}
