import 'package:flutter/material.dart';

class LabelValueFormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final TextEditingController controller;

  LabelValueFormField(
      {super.key, required this.label, required this.initialValue})
      : controller = TextEditingController(text: initialValue);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          enabled: false,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
