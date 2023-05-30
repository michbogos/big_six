import "package:flutter/material.dart";
import "package:app/exerciseListTile.dart";
import 'exerciseClass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Text(
            "Exercises",
            style: TextStyle(fontSize: 30),
          ),
        ),
        ...data.data.entries
            .map<Widget>((entry) => ExerciseListTile(exercise: entry.value)),
      ],
    );
  }
}
