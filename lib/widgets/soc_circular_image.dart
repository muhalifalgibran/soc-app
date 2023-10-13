import 'package:flutter/material.dart';

class SocCircularImage extends StatelessWidget {
  const SocCircularImage({
    required this.height,
    required this.width,
    this.image,
    super.key,
  });

  final double height, width;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        // make border radius always 50% to height
        borderRadius: BorderRadius.circular(height * 0.5),
        color: Colors.grey,
      ),
      child: image ?? Container(),
    );
  }
}
