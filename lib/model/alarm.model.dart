class Alarm {
  int id;
  DateTime time;
  bool aggressive;

  Alarm(this.id, this.time, this.aggressive);

  factory Alarm.fromJson(dynamic json) {
    return Alarm(json['id'] as int, DateTime.parse(json['time'] as String),
        json['aggressive'] as bool);
  }

  @override
  String toString() {
    return '{ $id, ${time.toIso8601String()}, $aggressive }';
  }
}
