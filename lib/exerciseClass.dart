import 'package:flutter_native_splash/cli_commands.dart';
import 'package:json_annotation/json_annotation.dart';
part 'exerciseClass.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  final Map<String, Exercise> data;
  Data(this.data);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Exercise {
  String id;
  Map<DateTime, SessionData> data;
  String displayName = "";
  int best = 0;
  Exercise(
    this.id,
    this.data, {
    String displayName = "",
    int best = 0,
  }) {
    this.displayName = displayName == "" ? id.capitalize() : displayName;
    this.best = best;
  }

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}

@JsonSerializable()
class SessionData {
  final int reps;
  final int duration;
  SessionData(this.reps, this.duration);

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);
}
