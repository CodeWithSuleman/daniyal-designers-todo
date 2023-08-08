import 'package:daniyal_designers_todo/models/todo_model.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  final User user;

  const UserDetailsCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${user.name}"),
          Text("PhoneNumber: ${user.phoneNumber}"),
          Text("waist: ${user.waist}"),
          Text("Height: ${user.height}"),
          Text("CollarNumber: ${user.collarNumber}"),
          Text("Delivery Date: ${user.deliveryDate}"),
        ],
      ),
    );
  }
}
