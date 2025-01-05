class Project {
  final String name;
  final String duration;
  final String members;
  final String location;
  final String amount;
  final String status;


  Project({
    required this.name,
    required this.duration,
    required this.members,
    required this.location,
    required this.amount,
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] ?? '',
      duration: json['duration'] ?? '',
      members: json['members'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? '',
      amount: json['amount'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
    "name": name,
    "duration": duration,
    "members": members,
    "location": location,
    "status": status,
    "amount": amount,
  };
}