import 'package:app/exerciseClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/exerciseScreen.dart';

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile({Key? key, required this.exercise}) : super(key: key);

  final Exercise exercise;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        child: SvgPicture.asset(
          "assets/images/${exercise.id}.svg",
          width: MediaQuery.of(context).size.width / 5,
        ),
        tag: exercise,
      ),
      title: Text("${exercise.displayName}"),
      subtitle: Text("Best: ${exercise.best}"),
      trailing: IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FutureBuilder<bool?>(
                future: Future.value(false),
                builder: (context, snapshot) => ExerciseScreen(
                  canVibrate: false,
                  excercise: exercise.id,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
