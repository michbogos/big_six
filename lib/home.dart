import "package:app/infoScreen.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "statScreen.dart";

import 'dart:convert';

import "homeScreen.dart";

import "exerciseClass.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<SharedPreferences> req = SharedPreferences.getInstance();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: [
              FutureBuilder<SharedPreferences>(
                  future: req,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      Map<String, dynamic> jsonData = jsonDecode(
                          snapshot.data!.getString("exerciseData") ?? "");
                      return HomeScreen(data: Data.fromJson(jsonData));
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              StatScreen()
            ].elementAt(selected),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Progress",
          ),
        ],
        currentIndex: selected,
        onTap: (int index) {
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
