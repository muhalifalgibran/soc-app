import 'package:flutter/material.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget(this.posts, {super.key});
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 3) - 1;
    double height = (MediaQuery.of(context).size.width / 3) - 1;
    return Wrap(
      spacing: 1,
      runSpacing: 1,
      direction: Axis.horizontal,
      children: List.generate(
        posts.length,
        (index) => Container(
          height: height,
          width: width,
          color: Colors.grey.shade400,
          child: Image.network(
            posts[index].postPic,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
