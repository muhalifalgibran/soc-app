import 'package:flutter/material.dart';

class NeuContainer extends StatelessWidget {
  const NeuContainer({
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.white,
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(-4, -4),
          )
        ],
      ),
      child: child,
    );
  }
}
