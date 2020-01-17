import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/search_input_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class NavigationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        margin: EdgeInsets.only(
          left: 30,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SearchInputField(),
            NavigationButton(
              text: "HOME",
              icon: OMIcons.home,
              onPressed: () {},
              isActive: true,
            ),
            NavigationButton(
              text: "Create New",
              icon: OMIcons.playlistAdd,
              onPressed: () {},
            ),
            NavigationButton(
              text: "Control Panel",
              icon: Icons.person_outline,
              onPressed: () {},
            ),
            NavigationButton(
              text: "Deleted",
              icon: OMIcons.deleteSweep,
              onPressed: () {},
            ),
            NavigationButton(
              text: "Draft",
              icon: OMIcons.attachment,
              onPressed: () {},
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
      duration: Duration(milliseconds: Styling.durationAnimation),
      curve: Curves.easeInOutCubic,
      color: _selectedTheme[isActive ? ElementStylingParameters.primaryColor : ElementStylingParameters.primaryAccentColor],
      child: FlatButton(
        color: Colors.transparent,
        textColor: _selectedTheme[ElementStylingParameters.headerTextColor],
        onPressed: isActive ? (){} : onPressed,
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
