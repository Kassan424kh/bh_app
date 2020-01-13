import 'package:flutter/material.dart';

enum Elements { primary, primaryAccent, text, headerText, inputHintText, boxShadow }

class Styling {
  static final lightTheme = {
    Elements.primary: Color(0xffECFFFE),
    Elements.primaryAccent: Colors.white,
    Elements.text: Color(0xff262626),
    Elements.headerText: Color(0xff48F4DE),
    Elements.inputHintText: Color(0xff48F4DE).withOpacity(.63),
    Elements.boxShadow: Color(0xff45D1FF)
  };
  static final darkTheme = {
    Elements.primary: Color(0xff262626),
    Elements.primaryAccent: Colors.black,
    Elements.text: Color(0xffA5FFE2),
    Elements.headerText: Color(0xff00C0A7),
    Elements.inputHintText: Color(0xff00C0A7).withOpacity(.63),
    Elements.boxShadow: Color(0xff00FFF0)
  };
}
