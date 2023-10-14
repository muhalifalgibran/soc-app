import 'package:flutter/material.dart';

class SocCircularImage extends StatelessWidget {
  const SocCircularImage({
    required this.height,
    required this.width,
    this.child,
    super.key,
  });

  final double height, width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        // make border radius always 50% to height
        borderRadius: BorderRadius.circular(height * 0.5),
        color: Colors.grey,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child ?? Container(),
        ],
      ),
    );
  }
}
