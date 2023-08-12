import 'package:daniyal_designers_todo/models/todo_model.dart';
import 'package:daniyal_designers_todo/shared/text_styles.dart';

import 'package:flutter/material.dart';

class UserDetailsBox extends StatelessWidget {
  final User user;

  const UserDetailsBox({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      titleTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Details",
            style: TextStyles.largeHeadingStyles,
          ),
          SizedBox(height: deviceHeight * 0.02),
          Text("Height: ${user.height}"),
          Text("Waist: ${user.userWaist}"),
          Text("Collar Number: ${user.collarNumber}"),
          Text("Delivery Date: ${user.deliveryDate}"),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    );
  }
}
