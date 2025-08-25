
// Placeholder CityService model
class CityService {
  final String serviceName;
  final String date;
  final String time;
  final String location;
  final String category;
  final String status;
  final String description;
  final String authority;

  CityService({
    required this.serviceName,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
    required this.status,
    required this.description,
    required this.authority,
  });

  factory CityService.fromJson(Map<String, dynamic> json) {
    return CityService(
      serviceName: json['serviceName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      authority: json['authority'] ?? '',
    );
  }
}
