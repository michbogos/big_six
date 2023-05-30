// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exerciseClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Exercise.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'data': instance.data.map((k, e) => MapEntry(k, e.toJson())),
    };

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      json['id'] as String,
      (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            DateTime.parse(k), SessionData.fromJson(e as Map<String, dynamic>)),
      ),
      displayName: json['displayName'] as String? ?? "",
      best: json['best'] as int? ?? 0,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'data': instance.data
          .map((k, e) => MapEntry(k.toIso8601String(), e.toJson())),
      'displayName': instance.displayName,
      'best': instance.best,
    };

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
      json['reps'] as int,
      json['duration'] as int,
    );

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'reps': instance.reps,
      'duration': instance.duration,
    };
