import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_form_field.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class Login extends StatelessWidget {
  final String title;
  final _formKey = GlobalKey<FormState>();

  Login({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightTheme[Elements.primaryAccent],
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 300,
            color: Styling.lightTheme[Elements.primary],
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    width: 300,
                    height: 100,
                    child: Image.asset(
                      "assets/images/bh_logo_hell.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ClipRect(
                    child: Container(
                      height: 230,
                      width: 300,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 50),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                HeaderText(text: "LOGIN"),
                                SizedBox(height: 20),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      UITextFormField(
                                        hintText: "Username",
                                        maxLines: 1,
                                        maxLength: 30,
                                      ),
                                      UITextFormField(
                                        hintText: "Password",
                                        maxLines: 1,
                                        maxLength: 30,
                                        obscureText: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter.add(Alignment(0, 0.2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                          Styling.lightTheme[Elements.headerText],
                          Styling.lightTheme[Elements.boxShadow],
                        ], stops: [
                          0,
                          100
                        ]),
                      ),
                      child: Center(
                        child: IconButton(
                          hoverColor: Colors.transparent,
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Styling.lightTheme[Elements.primaryAccent],
                          ),
                          alignment: Alignment.center,
                          autofocus: false,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          color: Colors.transparent,
                          disabledColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
