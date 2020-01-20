import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';
import 'package:flutter_berichtsheft_app/components/go_and_back_ui_buttons.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ImportReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Site(
      title: "Import Reports",
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              UITextField(
                icon: Icon(Icons.vpn_key, color: Provider.of<StylingProvider>(context).selectedTheme[ElementStylingParameters.headerTextColor]),
                onChanged: (s) {},
                marginLeft: 50,
                hintText: "API key here",
              ),
              SizedBox(height: 20),
              UITextField(
                onChanged: (s) {},
                marginLeft: 50,
                hintText: "From Json Code",
                maxLines: 10,
              ),
            ],
          ),
        ),
        SizedBox(height: 60),
        GoAndBackUiButtons()
      ],
    );
  }
}
