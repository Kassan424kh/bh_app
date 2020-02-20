import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/MyApp.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:jose/jose.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // create a builder
    var builder = new JsonWebSignatureBuilder();

    // set the content
    builder.jsonContent = {"email" : "k.khalil@satzmedia.de", "password" : "Hei8chur"};

    // add a key to sign, you can add multiple keys for different recipients
    builder.addRecipient(
        new JsonWebKey.generate("password"),
        algorithm: "HS256");

    // build the jws
    var jws = builder.build();

    // output the compact serialization
    print("jws compact serialization: ${jws.toCompactSerialization()}");


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<UserData>(
          create: (_) => UserData(),
        ),
        ChangeNotifierProvider<StylingProvider>(
          create: (_) => StylingProvider(),
        ),
        ChangeNotifierProvider<NavigateProvider>(
          create: (_) => NavigateProvider(),
        ),
        ChangeNotifierProvider<ReportsProvider>(
          create: (_) => ReportsProvider(),
        ),
        ChangeNotifierProvider<MessageProvider>(
          create: (_) => MessageProvider(),
        ),
        ChangeNotifierProvider<LoadingProgress>(
          create: (_) => LoadingProgress(),
        ),
      ],
      child: Consumer<NavigateProvider>(
        builder: (_, settings, child) {
          return MaterialApp(home: MyApp());
        },
      ),
    );
  }
}
