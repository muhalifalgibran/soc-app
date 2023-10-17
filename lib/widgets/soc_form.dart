import 'package:flutter/material.dart';

class SocForm extends StatelessWidget {
  const SocForm({
    required this.label,
    this.onChanged,
    this.obscure = false,
    super.key,
  });

  final String label;
  final bool obscure;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
          TextFormField(
            obscureText: obscure,
            style: const TextStyle(fontSize: 14.0),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
