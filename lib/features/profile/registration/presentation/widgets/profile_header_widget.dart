import 'package:flutter/material.dart';
import 'package:soc_app/widgets/neu_container.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_circular_image.dart';

class ProfileHeadWidget extends StatelessWidget {
  const ProfileHeadWidget({this.isCurrentUser = false, super.key});
  final bool isCurrentUser;
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
              const SocCircularImage(height: 72, width: 72),
              const SizedBox(
                width: 21,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@username',
                    style: TextStyle(
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
                          Text('29'),
                          SizedBox(height: 4),
                          Text('Posts'),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      // Followers
                      Column(
                        children: [
                          Text('12'),
                          SizedBox(height: 4),
                          Text('Followers'),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      // following
                      Column(
                        children: [
                          Text('0'),
                          SizedBox(height: 4),
                          Text('Following'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isCurrentUser
                      ? SocButton(
                          width: 100,
                          height: 40,
                          onPressed: () {},
                          color: Colors.red.shade300,
                          label: 'Logout',
                        )
                      : SocButton(
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
