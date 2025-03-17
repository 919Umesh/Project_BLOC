import 'package:flutter/material.dart';

class TextFieldFormat extends StatelessWidget {
  final String textFieldName;
  final Widget textFormField;

  const TextFieldFormat({
    super.key,
    required this.textFieldName,
    required this.textFormField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        textFormField,
      ],
    );
  }
}