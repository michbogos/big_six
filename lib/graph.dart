import 'dart:math';

import 'package:intl/intl.dart';
import 'package:app/exerciseClass.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key, this.exercise = "pushup", required this.data})
      : super(key: key);

  final String exercise;
  final Data data;

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  List<BarChartGroupData> chartData = [];
  int index = 0;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return widget.data.data[widget.exercise]?.data.keys.length == null
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrientationBuilder(
              builder: ((context, orientation) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height *
                      (MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 0.479
                          : 0.728),
                  child: Column(
                    children: [
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            barGroups: widget
                                .data.data[widget.exercise]?.data.entries
                                .toList()
                                .sublist(
                                    max(5 * selected, 0),
                                    min(
                                        5 * (selected + 1),
                                        widget.data.data[widget.exercise]!.data
                                            .length))
                                .map(
                              (entry) {
                                index++;
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                        toY: entry.value.reps.toDouble(),
                                        width: 20,
                                        borderRadius: BorderRadius.circular(5)),
                                  ],
                                  showingTooltipIndicators: [0],
                                );
                              },
                            ).toList(),
                            titlesData: FlTitlesData(
                              show: true,
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  reservedSize:
                                      MediaQuery.of(context).size.width * 0.07,
                                  getTitlesWidget: (value, meta) {
                                    return Text("${value.toInt()}");
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize:
                                      MediaQuery.of(context).size.height * 0.07,
                                  getTitlesWidget: (value, meta) {
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        DateFormat.Md().format(
                                          widget.data.data[widget.exercise]!
                                              .data.keys
                                              .toList()
                                              .sublist(
                                                  max(5 * selected, 0),
                                                  min(
                                                      5 * (selected + 1),
                                                      widget
                                                          .data
                                                          .data[
                                                              widget.exercise]!
                                                          .data
                                                          .length))
                                              .elementAt(value.toInt() - 1),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            barTouchData: BarTouchData(
                              enabled: false,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.transparent,
                                tooltipMargin: 8,
                                tooltipPadding: EdgeInsets.zero,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    rod.toY.round().toString(),
                                    TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 120,
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                print("$selected");
                                index = 0;
                                setState(() {
                                  selected = max(0, selected - 1);
                                });
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                            Text(
                                "${DateFormat.yMMMd().format(widget.data.data[widget.exercise]?.data.entries.toList().sublist(max(5 * selected, 0), min(5 * (selected + 1), widget.data.data[widget.exercise]!.data.length)).elementAt(0).key ?? DateTime.now())}  -- ${DateFormat.yMMMd().format(widget.data.data[widget.exercise]?.data.entries.toList().sublist(max(5 * selected, 0), min(5 * (selected + 1), widget.data.data[widget.exercise]!.data.length)).last.key ?? DateTime.now())}"),
                            IconButton(
                              onPressed: () {
                                index = 0;
                                if ((selected + 1) * 5 <
                                    widget.data.data[widget.exercise]!.data
                                        .length) {
                                  setState(() {
                                    selected = selected + 1;
                                  });
                                }
                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ])
                    ],
                  ),
                );
              }),
            ),
          );
  }
}
