import 'package:flutter/material.dart';

class NullImage extends StatelessWidget {
  final String image;

  NullImage({
    Key key,
    this.image = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        width: constraints.maxWidth,
        height: 200,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Image.asset(
          image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
