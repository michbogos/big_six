import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Info',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 1.0,
            child: Text("How to use"),
          ),
        ],
      ),
    );
  }
}
