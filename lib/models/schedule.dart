class Schedule {
  final String id;
  final String date;
  final String time;
  final String location;
  final List types;

  Schedule({
    required this.id,
    required this.date,
    required this.time,
    required this.location,
    required this.types,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      date: json['date'],
      time: json['time'],
      location: json['location'],
      types: List<String>.from(json['types']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'location': location,
      'types': types,
    };
  }
}
