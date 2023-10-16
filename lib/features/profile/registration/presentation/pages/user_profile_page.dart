import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/image_grid_widget.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/profile_header_widget.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => getIt<ProfileCubit>()
        ..getProfile()
        ..getPosts(),
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
            BlocBuilder<ProfileCubit, ProfileState>(
              bloc: getIt<ProfileCubit>(),
              builder: (context, state) {
                if (state.isSuccessGetPosts) {
                  return ImageGridWidget(state.posts ?? []);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
