import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'package:app/resultsScreen.dart';
import 'exerciseClass.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen(
      {Key? key, required this.canVibrate, required this.excercise})
      : super(key: key);

  final bool canVibrate;
  final String excercise;
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int counter = 0;
  int minutes = 0;
  int seconds = 0;
  int timeInt = 0;
  String timeString = "";
  late Timer timer;
  late SharedPreferences prefs;

  void timerCallback(timer) {
    seconds++;
    timeInt++;
    if (seconds == 60) {
      seconds %= 60;
      minutes++;
    }
    setState(() {
      timeString =
          "${"$minutes".length < 2 ? "0$minutes" : "$minutes"}:${"$seconds".length < 2 ? "0$seconds" : "$seconds"}";
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), timerCallback);
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Map<String, dynamic> jsonData =
            jsonDecode(prefs.getString("exerciseData") ?? "");
        Data data = Data.fromJson(jsonData);
        data.data[widget.excercise]?.data[DateTime.now()] =
            SessionData(counter, timeInt);
        if (counter > (data.data[widget.excercise]?.best ?? 0)) {
          data.data[widget.excercise]?.best = counter;
        }
        prefs.setString("exerciseData", json.encode(data));
        Navigator.pop(context, false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultsScreen(
              reps: counter,
              time: timeString,
            ),
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            if (widget.canVibrate) {
              Vibration.vibrate(duration: 200);
            }
            setState(() {
              counter++;
            });
          },
          child: Column(
            children: [
              Center(
                child: Hero(
                  child: SvgPicture.asset(
                      "assets/images/${widget.excercise}.svg",
                      height: MediaQuery.of(context).size.height * 0.3),
                  tag: widget.excercise,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "$counter",
                      style: TextStyle(
                        fontSize: 100,
                      ),
                    ),
                    Text(
                      timeString,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
