import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular((350 * (size.width > Styling.tabletSize ? 35: 20) / 100) * 2)),
      child: Container(
        height: (350 * (size.width > Styling.tabletSize ? 35: 20) / 100),
        width: (350 * (size.width > Styling.tabletSize ? 35: 20) / 100),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                _selectedTheme[SitesIcons.avatarImage],
              ),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
