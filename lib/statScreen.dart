import 'package:flutter/material.dart';
import 'graph.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/exerciseClass.dart';
import 'dart:convert';

Future<Data> dataRequest() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> jsonData =
      jsonDecode(prefs.getString('exerciseData') ?? "");
  return Data.fromJson(jsonData);
}

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  Future<Data> request = dataRequest();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Data>(
      future: request,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              title: const Center(
                child: Text('Stats'),
              ),
            ),
            body: DefaultTabController(
              length: snapshot.data!.data.keys.length,
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: orientation == Orientation.portrait
                        ? Column(
                            children: [
                              Expanded(
                                child: common(snapshot, context),
                              ),
                              TabPageSelector(
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          )
                        : common(snapshot, context),
                  );
                  //ListView(children: [common(snapshot, context)]);
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: Text('Stats'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Widget common(snapshot, context) {
  return TabBarView(
    viewportFraction: 1,
    children: snapshot.data!.data.entries
        .map<Widget>(
          (e) => Column(
            children: [
              Center(
                child: Text(
                  e.value.displayName,
                  style: TextStyle(
                      backgroundColor: Theme.of(context).colorScheme.surface),
                ),
              ),
              Graph(
                exercise: e.value.id,
                data: snapshot.data ?? Data({}),
              ),
            ],
          ),
        )
        .toList(),
  );
}
