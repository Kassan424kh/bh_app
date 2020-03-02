import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/MyApp.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  return runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
