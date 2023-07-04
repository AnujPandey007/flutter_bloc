import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String headerTitle;
  const CustomHeader({super.key, required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        headerTitle,
        style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500
        ),
      ),
      tileColor: Colors.grey.shade200,
    );
  }
}
