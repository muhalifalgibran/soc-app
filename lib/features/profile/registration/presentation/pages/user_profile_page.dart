import 'package:flutter/material.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/image_grid_widget.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/profile_header_widget.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeadWidget(),
          Container(
            height: 1,
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 2),
          ),
          ImageGridWidget(),
        ],
      ),
    ));
  }
}
