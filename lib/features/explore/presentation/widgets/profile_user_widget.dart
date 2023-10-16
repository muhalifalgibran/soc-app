import 'package:flutter/material.dart';
import 'package:soc_app/features/post/domain/entities/post.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/widgets/soc_button.dart';

import '../../../../widgets/soc_circular_image.dart';

class ProfileUserWidget extends StatelessWidget {
  const ProfileUserWidget(this.user, this.posts, {super.key});
  final SocUser user;
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 80,
        bottom: 20,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SocCircularImage(
                  height: 72,
                  width: 72,
                  child: user.picUrl != null || user.picUrl != ''
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(72 * 0.5),
                          child: Image.network(
                            user.picUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null),
              const SizedBox(
                width: 21,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${user.username}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // post
                      Column(
                        children: [
                          Text('${posts.length}'),
                          const SizedBox(height: 4),
                          const Text('posts'),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      // Followers
                      Column(
                        children: [
                          Text('${user.followee.length}'),
                          const SizedBox(height: 4),
                          const Text('followers'),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      // following
                      Column(
                        children: [
                          Text('${user.following.length}'),
                          const SizedBox(height: 4),
                          const Text('following'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SocButton(
                    width: 100,
                    height: 40,
                    onPressed: () {},
                    label: 'Follow',
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
