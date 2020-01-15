import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class NavigationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(
          left: 30,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              NavigationButton(
                text: "HOME",
                icon: Icons.home,
                onPressed: () {},
                isActive: true,
              ),
              NavigationButton(
                text: "Create New",
                icon: Icons.playlist_add,
                onPressed: () {},
              ),
              NavigationButton(
                text: "Control Panel",
                icon: Icons.person_outline,
                onPressed: () {},
              ),
              NavigationButton(
                text: "Deleted",
                icon: Icons.delete_sweep,
                onPressed: () {},
              ),
            ],
          ),
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
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 50,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => AnimatedContainer(
            duration: Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
            width: constraints.maxWidth,
            color: _selectedTheme[isActive ? ElementStylingParameters.primaryColor : ElementStylingParameters.primaryAccentColor],
            child: FlatButton(
              color: Colors.transparent,
              textColor: _selectedTheme[ElementStylingParameters.headerTextColor],
              onPressed: isActive ? (){} : onPressed,
              child: Row(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    width: isActive ? 0 : 30,
                  ),
                  Icon(icon),
                  SizedBox(width: 40),
                  Text(text)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
