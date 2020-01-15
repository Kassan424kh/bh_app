import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 20, bottom: 20),
        color: (_selectedTheme[ElementStylingParameters.editButtonColor] as Color).withOpacity(_selectedTheme[ElementStylingParameters.splashOpacity]),
        child: UITextField(
          hintText: "Search",
          icon: Icon(
            Icons.search,
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            size: 20,
          ),
        ),
      ),
    );
  }
}
