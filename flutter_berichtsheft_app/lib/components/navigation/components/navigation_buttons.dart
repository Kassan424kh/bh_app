import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/search_input_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class NavigationButtons extends StatefulWidget {

  @override
  _NavigationButtonsState createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  API _api;

  _updateShowingReports(BuildContext context){
    Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(false);
    Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports.clear();
    Provider.of<ReportsProvider>(context, listen: false).selectAllReports(Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports);
    _api.clearClient();
  }

  @override
  void initState() {
    setState(() {
      _api = API(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String _nowOpendedSite = Provider.of<NavigateProvider>(context).nowOpenedSite;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) => Container(
        margin: EdgeInsets.only(
          left: 30,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            SearchInputField(onTap: (){
              _updateShowingReports(context);
              Provider.of<NavigateProvider>(context, listen: false).goToSite("/search");
            },
              onSubmitted: (String v){
                print(v);
              },
            ),
            NavigationButton(
              text: "HOME",
              icon: OMIcons.home,
              onPressed: () {
                _updateShowingReports(context);
                Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
              },
              isActive: _nowOpendedSite == "/home" || _nowOpendedSite == "/" ,
            ),
            NavigationButton(
              text: "Create New",
              isActive: _nowOpendedSite == "/create-new" ,
              icon: OMIcons.playlistAdd,
              onPressed: () {
                _updateShowingReports(context);
                Provider.of<NavigateProvider>(context, listen: false).goToSite("/create-new");
              },
            ),
            NavigationButton(
              text: "Control Panel",
              icon: Icons.person_outline,
              isActive: _nowOpendedSite == "/control-panel",
              onPressed: (){
                //_updateShowingReports(context);
                //Provider.of<NavigateProvider>(context, listen: false).goToSite("/control-panel");
              },
            ),
            NavigationButton(
              text: "Deleted",
              isActive: _nowOpendedSite == "/deleted-reports",
              icon: OMIcons.deleteSweep,
              onPressed: () {
                _updateShowingReports(context);
                Provider.of<NavigateProvider>(context, listen: false).goToSite("/deleted-reports");
              },
            ),
            NavigationButton(
              text: "Draft",
              isActive: _nowOpendedSite == "/draft-reports",
              icon: OMIcons.attachment,
              onPressed: () {
                _updateShowingReports(context);
                Provider.of<NavigateProvider>(context, listen: false).goToSite("/draft-reports");
              },
            ),
            NavigationButton(
              text: "Duplicated Reports",
              isActive: _nowOpendedSite == "/duplicated-reports",
              icon: OMIcons.layers,
              onPressed: () {
                _updateShowingReports(context);
                Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final onPressed;

  NavigationButton({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 20),
      height: 50,
      duration: Duration(milliseconds: (Styling.durationAnimation / 5).round()),
      curve: Curves.easeInOutCubic,
      color: _selectedTheme[isActive ? ElementStylingParameters.primaryColor : ElementStylingParameters.primaryAccentColor],
      child: FlatButton(
        color: Colors.transparent,
        textColor: _selectedTheme[ElementStylingParameters.headerTextColor],
        onPressed: isActive ? () {} : onPressed,
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: Styling.durationAnimation),
              curve: Curves.easeInOutCubic,
              width: isActive ? 0 : 30,
            ),
            Icon(icon),
            SizedBox(width: 40),
            Text(text)
          ],
        ),
      ),
    );
  }
}
