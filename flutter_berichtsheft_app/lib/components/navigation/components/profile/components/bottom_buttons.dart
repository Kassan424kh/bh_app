import 'package:crypted_preferences/crypted_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/ui_circle_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomButtons extends StatefulWidget {
  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  Future<SharedPreferences> sPrefs;
  _updateShowingReports(BuildContext context) {
    Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(false);
  }

  @override
  void initState() {
    setState(() {
      sPrefs = SharedPreferences.getInstance();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      width: 350 * 70 / 100,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          UICircleButton(
            toolTipMessage: "Logout",
            color: _selectedTheme[ElementStylingParameters.logoutButtonColor],
            icon: Icons.power_settings_new,
            buttonSize: 40,
            onClick: () async {
              final prefs = await Preferences.preferences(path: "./loginData");
              prefs.remove("accessToken");
              final SharedPreferences _sPrefs = await sPrefs;
              if (Theme.of(context).platform ==  TargetPlatform.android) _sPrefs.remove("accessToken");
              Provider.of<LoginProvider>(context, listen: false).updateLoginStatus(
                Provider.of<LoginProvider>(context, listen: false).isLoggedIn ? false : true,
              );
            },
          ),
          UICircleButton(
            toolTipMessage: "Import Reports",
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            icon: OMIcons.cloudUpload,
            buttonSize: 40,
            onClick: () {
              _updateShowingReports(context);
              Provider.of<NavigateProvider>(context, listen: false).goToSite("/import-reports");
            },
          ),
          UICircleButton(
            toolTipMessage: "Export/Save Reports as JSON",
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            icon: Icons.save_alt,
            buttonSize: 40,
            onClick: () {},
          ),
          UICircleButton(
            toolTipMessage: Provider.of<StylingProvider>(context).selectedTheme == Styling.darkTheme ? "Darkmode" : "Nightmode",
            color: _selectedTheme[ElementStylingParameters.lightDarkButtonColor],
            icon: _selectedTheme[ElementStylingParameters.lightDarkButtonIcon],
            buttonSize: 40,
            onClick: () {
              Provider.of<StylingProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
      ),
    );
  }
}
