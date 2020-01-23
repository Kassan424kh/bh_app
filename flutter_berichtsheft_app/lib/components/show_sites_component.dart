import 'package:flutter/material.dart';

class ShowSitesComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Hero(
      tag: "login_button_to_sites_container_component",
      child: Container(
        height: _size.height,
        width: _size.width - 390,
        color: Colors.red,
      ),
    );
  }
}
