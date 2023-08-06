import 'package:uuid/uuid.dart';

class User {
  final String? id;
  final String name;
  final String collarNumber;
  final int waist;
  final int height;
  final int phoneNum;
  final DateTime selectedDate;

  User(
      {
        this.id,
    required this.selectedDate,
    required this.phoneNum,
    required this.name,
    required this.collarNumber,
    required this.waist,
    required this.height, 
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'collarNumber': collarNumber,
        'id': const Uuid().v4(),
        'waist': waist,
        'height': height,
        'phoneNum': phoneNum,
        'selectedDate':selectedDate,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      selectedDate: json["selectedDate"],
      id: json["id"], 
      phoneNum: json["phoneNum"],
      name: json["name"],
      collarNumber: json["collarNumber"],
      waist: json["waist"],
      height: json["height"],
    );
  }
}
