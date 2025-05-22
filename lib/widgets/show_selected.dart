// lib/widgets/show_selected.dart
import 'package:flutter/material.dart';

class ShowSelected extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPressed;

  const ShowSelected({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.only(
              right: 40,
            ),
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey,
          width: double.infinity,
        ),
      ],
    );
  }
}
