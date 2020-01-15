import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';
import 'package:flutter_berichtsheft_app/components/ui_circle_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_form_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final String title;

  Login({Key key, this.title}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  Widget _loginForm = Form(
    //key: _formKey,
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
          borderBottom: false,
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        AppLogo(padding: EdgeInsets.all(15)),
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
                        SizedBox(height: 15),
                        HeaderText(text: "LOGIN"),
                        SizedBox(height: 15),
                        _loginForm,
                        SizedBox(height: 15),
                        UICircleButton(
                          onPressed: () {
                            Provider.of<LoginProvider>(context, listen: false).updateLoginStatus(
                              Provider.of<LoginProvider>(context, listen: false).isLoggedIn ? false : true,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
