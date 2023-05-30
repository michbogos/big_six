import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key, this.reps = -1, this.time = "00:00"})
      : super(key: key);

  final int reps;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout finished')),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reps",
                      style: TextStyle(fontSize: 45),
                    ),
                    Text(
                      "$reps",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(fontSize: 45),
                    ),
                    Text(
                      "$time",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("Back to home")),
          ),
        ],
      ),
    );
  }
}
