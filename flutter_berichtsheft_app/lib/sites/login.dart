import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/header_text.dart';
import 'package:flutter_berichtsheft_app/components/ui_login_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_form_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final String title;

  Login({Key key, this.title}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  bool _emailValidate = false;
  String _password = "";
  bool _passwordValidate = false;
  API _api;

  var _passwordController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _api = API(context: context);
    });
    super.initState();
  }

  void _validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    setState(() {
      if (!regex.hasMatch(value) || value == "")
        _emailValidate = true;
      else
        _emailValidate = false;
    });
  }

  void _login(BuildContext context){
    if (!_emailValidate && !_passwordValidate)
      _api.login(_email, _password).then((bool value) {
        Provider.of<LoginProvider>(context, listen: false).updateLoginStatus(value);
      });
  }

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
                        Form(
                          child: Column(
                            children: <Widget>[
                              UITextFormField(
                                hintText: "Email",
                                onChanged: (v) {
                                  setState(() {
                                    _email = v;
                                  });
                                  _validateEmail(_email);
                                },
                                onFieldSubmitted: (s) {
                                  setState(() {
                                    _passwordValidate = _password == "" ? true : false;
                                  });
                                  _validateEmail(_email);
                                  _login(context);
                                },
                                validate: _emailValidate,
                                maxLines: 1,
                                maxLength: 30,
                              ),
                              UITextFormField(
                                controller: _passwordController,
                                hintText: "Password",
                                onChanged: (v) {
                                  setState(() {
                                    if (v.contains("•"))
                                      _passwordController.clear();
                                    else
                                      _password = v;
                                    _passwordValidate = _password == "" ? true : false;
                                  });
                                },
                                onFieldSubmitted: (s) {
                                  setState(() {
                                    _passwordValidate = _password == "" ? true : false;
                                  });
                                  _validateEmail(_email);

                                  _login(context);
                                },
                                validate: _passwordValidate,
                                maxLines: 1,
                                maxLength: 30,
                                obscureText: true,
                                borderBottom: false,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        UILoginButton(
                          onPressed: () {
                            _login(context);
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
