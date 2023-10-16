import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/explore/presentation/cubits/detail_profile_post_cubit.dart';
import 'package:soc_app/features/explore/presentation/widgets/profile_user_widget.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/image_grid_widget.dart';

class DetailUserPage extends StatelessWidget {
  const DetailUserPage(this.user, {super.key});
  final SocUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailProfilePostCubit, DetailProfilePostState>(
        bloc: getIt<DetailProfilePostCubit>()
          ..getPosts(
            user.authUid!,
          ),
        builder: (context, state) {
          if (state.isSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileUserWidget(
                    user,
                    state.posts!,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(bottom: 2),
                  ),
                  ImageGridWidget(state.posts ?? []),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
