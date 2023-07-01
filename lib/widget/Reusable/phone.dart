import 'package:flutter/material.dart';

class PhoneNumberWidget extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumberWidget({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.phone),
        const SizedBox(width: 8.0),
        Text(
          phoneNumber,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
