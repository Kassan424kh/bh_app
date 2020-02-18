import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/go_and_back_ui_buttons.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ImportReports extends StatefulWidget {
  @override
  _ImportReportsState createState() => _ImportReportsState();
}

class _ImportReportsState extends State<ImportReports> {
  API _api;
  String key;

  @override
  void initState() {
    super.initState();
    setState(() {
      _api = API(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Site(
      siteRoute: "/import-reports",
      title: "Import Reports",
      children: <Widget>[
        Column(
          children: <Widget>[
            UITextField(
              icon: Icon(Icons.vpn_key, color: Provider.of<StylingProvider>(context).selectedTheme[ElementStylingParameters.headerTextColor]),
              onChanged: (s) {
                setState(() {
                  key = s;
                });
              },
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
        SizedBox(height: 60),
        GoAndBackUiButtons(
          onClickGoButton: () {
            _api.importFromRedmine(key);
          },
        )
      ],
    );
  }
}
