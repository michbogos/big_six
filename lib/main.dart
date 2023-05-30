import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:io";
import "package:intl/date_symbol_data_local.dart";
import "color_schemes.g.dart";

import 'home.dart';
import "firstStartScreen.dart";

void main() {
  initializeDateFormatting(Platform.localeName, null)
      .then((_) => runApp(const Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int count = 0;
  bool firstTime = true;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future<void> locale = initializeDateFormatting(Platform.localeName);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<SharedPreferences>(
        future: prefs,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return (snapshot.data?.getBool("firstTime") ?? true)
                ? FirstStartScreen()
                : Home();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}
