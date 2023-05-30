import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'exerciseClass.dart';

import 'home.dart';

class FirstStartScreen extends StatelessWidget {
  const FirstStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      dotsDecorator:
          DotsDecorator(activeColor: Theme.of(context).colorScheme.primary),
      pages: [
        PageViewModel(
          title: "Welcome to Big Six",
          body: "This app is designed to guide you on your fitness journey.",
          image: const Center(
            child: Icon(
              FontAwesomeIcons.person,
              size: 50.0,
              color: Colors.transparent,
            ),
          ),
        ),
        PageViewModel(
            title: "The six core excercises are...",
            bodyWidget: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/images/pushup.svg",
                        ),
                      ),
                      Text("Pushups"),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/images/pullup.svg",
                        ),
                      ),
                      Text("Pullups"),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/images/squat.svg",
                        ),
                      ),
                      Text("Squats"),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/images/legraises.svg",
                        ),
                      ),
                      Text("Leg Raises"),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/images/bridge.svg",
                        ),
                      ),
                      Text("Bridges"),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/images/handstand.svg",
                        ),
                      ),
                      Text("Handstand"),
                    ],
                  ),
                ],
              ),
            ))
      ],
      showNextButton: false,
      done: const Text("Done"),
      onDone: () {
        SharedPreferences.getInstance().then((preferences) {
          preferences.setBool("firstTime", false);
          Data data = Data(
            {
              "pushup": Exercise("pushup", {
                DateTime.now(): SessionData(0, 0),
              }),
              "pullup": Exercise("pullup", {
                DateTime.now(): SessionData(0, 0),
              }),
              "squat": Exercise("squat", {
                DateTime.now(): SessionData(0, 0),
              }),
              "bridge": Exercise("bridge", {
                DateTime.now(): SessionData(0, 0),
              }),
              "legraises": Exercise(
                  "legraises",
                  {
                    DateTime.now(): SessionData(0, 0),
                  },
                  displayName: "Leg raises"),
              "handstand": Exercise("handstand", {
                DateTime.now(): SessionData(0, 0),
              }),
            },
          );
          preferences.setString("exerciseData", json.encode(data));
        });
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      },
    );
  }
}
