import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool? isDense;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;

  const PrimaryTextField({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.isDense = true,
    required this.hintText,
    this.hintStyle = const TextStyle(fontSize: 12),
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        isDense: isDense,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        hintText: hintText,
        hintStyle: hintStyle,
      ),
      validator: validator,
    );
  }
}
