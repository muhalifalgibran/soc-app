import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/explore/presentation/cubits/detail_profile_post_cubit.dart';
import 'package:soc_app/features/explore/presentation/cubits/explore_cubit.dart';
import 'package:soc_app/features/explore/presentation/cubits/follow_unfollow_cubit.dart';
import 'package:soc_app/features/explore/presentation/widgets/profile_user_widget.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/image_grid_widget.dart';
import 'package:soc_app/features/your_page/presentation/cubits/your_page_cubit.dart';

class DetailUserPage extends StatefulWidget {
  const DetailUserPage(this.user, {super.key});
  final SocUser user;

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  String currentUserId = '';
  @override
  void initState() {
    super.initState();
    initCurrentUserId();
  }

  void initCurrentUserId() async {
    final box = await Hive.openBox('userStatus');
    currentUserId = box.get('userUid');
  }

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailProfilePostCubit, DetailProfilePostState>(
        bloc: getIt<DetailProfilePostCubit>()
          ..getPosts(
            widget.user.authUid!,
          ),
        builder: (context, state) {
          if (state.isSuccess) {
            return BlocListener<FollowUnfollowCubit, FollowUnfollowState>(
              bloc: getIt<FollowUnfollowCubit>(),
              listener: (context, state) {
                if (state.isLoading) {
                  showLoading();
                } else if (state.isSuccessFollow || state.isSuccessUnfollow) {
                  // pop the loading animation
                  Navigator.pop(context);
                  //
                  Navigator.pop(context);
                  // get the data again
                  getIt<DetailProfilePostCubit>().getPosts(
                    widget.user.authUid!,
                  );
                  getIt<YourPageCubit>().getYourPage();
                  context.read<ProfileCubit>()
                    ..getPosts()
                    ..getProfile();
                  getIt<ExploreCubit>().getUsers();
                  setState(() {});
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileUserWidget(
                      widget.user,
                      state.posts!,
                      currentUserId,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(bottom: 2),
                    ),
                    ImageGridWidget(state.posts ?? []),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
