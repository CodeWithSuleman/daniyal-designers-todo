import 'package:uuid/uuid.dart';

class User {
  final String? id;
  final String name;
  final String collarNumber;
  final int waist;
  final int height;
  final int phoneNumber;
  final String deliveryDate;

  User({
    this.id,
    required this.deliveryDate,
    required this.phoneNumber,
    required this.name,
    required this.collarNumber,
    required this.waist,
    required this.height,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'collar_number': collarNumber,
        'id': const Uuid().v4(),
        'waist': waist,
        'height': height,
        'phone_number': phoneNumber,
        'delivery_date': deliveryDate,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      deliveryDate: json["delivery_date"],
      id: json["id"],
      phoneNumber: json["phone_number"],
      name: json["name"],
      collarNumber: json["collar_number"],
      waist: json["waist"],
      height: json["height"],
    );
  }
}
