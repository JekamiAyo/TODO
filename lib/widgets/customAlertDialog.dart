import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final controller;
  final void Function() onSave;
  final void Function() onCancel;
  const CustomAlertDialog(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Add new task",
            hintStyle: TextStyle(color: Colors.grey)),
      ),
      actions: [
        MaterialButton(
          color: Colors.grey[700],
          onPressed: onSave,
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        MaterialButton(
          color: Colors.grey[700],
          onPressed: onCancel,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
