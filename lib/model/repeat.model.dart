import 'dart:convert';

import 'package:equatable/equatable.dart';

class Repeat extends Equatable {
  final RepeatType type;
  final String payload;

  Repeat({this.type, this.payload});

  factory Repeat.fromJson(String string) {
    final dynamic json = jsonDecode(string);
    return Repeat(
        type: stringToRepeatType(json['time'] as String),
        payload: json['payload'] as String);
  }

  String toJson() {
    return '''{ "type": "${repeatToString(type)}", "payload": "$payload" }''';
  }

  static RepeatType stringToRepeatType(String en) {
    switch (en) {
      case 'RepeatType.daily':
        return RepeatType.daily;
      case 'RepeatType.weekly':
        return RepeatType.weekly;
      case 'RepeatType.monthly':
        return RepeatType.monthly;
      case 'RepeatType.yearly':
        return RepeatType.yearly;
      case 'RepeatType.never':
      default:
        return RepeatType.never;
    }
  }

  static String repeatToString(RepeatType en) {
    switch (en) {
      case RepeatType.daily:
        return 'daily';
      case RepeatType.weekly:
        return 'weekly';
      case RepeatType.monthly:
        return 'monthly';
      case RepeatType.yearly:
        return 'yearly';
      case RepeatType.never:
        return 'never';
      default:
        return 'never';
    }
  }

  Repeat copyWith({RepeatType type, String payload}) {
    return Repeat(
      type: type ?? this.type,
      payload: payload ?? this.payload,
    );
  }

  @override
  String toString() {
    return 'Repeat{type: $type, payload: $payload}';
  }

  @override
  List<Object> get props => [type, payload];
}

enum RepeatType { daily, weekly, monthly, yearly, never }

/*
* giorno
* settimana - giorni [L,M,M,G,V,S,D]
* mese - stesso numero o stesso giorno
* anno
* */
