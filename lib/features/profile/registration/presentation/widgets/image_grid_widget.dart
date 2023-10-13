import 'package:flutter/material.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 3) - 1;
    double height = (MediaQuery.of(context).size.width / 3) - 1;
    return Container(
      child: Wrap(
        spacing: 1,
        runSpacing: 1,
        direction: Axis.horizontal,
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade400,
          ),
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade400,
          ),
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade400,
          ),
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade400,
          ),
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade400,
          ),
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
