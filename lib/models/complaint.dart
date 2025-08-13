class Complaint {
  final String id;
  final String title;
  final String date;
  final String time;
  final String status;
  final String resolvedDate;
  final String imageUrl;
  final String category;
  final String specificIssue;
  final String description;

  Complaint({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    required this.resolvedDate,
    required this.imageUrl,
    required this.category,
    required this.specificIssue,
    required this.description,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      resolvedDate: json['resolvedDate'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      specificIssue: json['specificIssue'],
      description: json['description'],
    );
  }

  String get formattedDate {
    return '$date • $time';
  }
}
