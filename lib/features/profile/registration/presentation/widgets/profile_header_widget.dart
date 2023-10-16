import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';
import 'package:soc_app/features/profile/registration/presentation/pages/login_page.dart';
import 'package:soc_app/widgets/soc_button.dart';
import 'package:soc_app/widgets/soc_circular_image.dart';

class ProfileHeadWidget extends StatelessWidget {
  const ProfileHeadWidget({this.isCurrentUser = true, super.key});
  final bool isCurrentUser;

  void showLoading(BuildContext context) {
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
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.isLoadingLogout) {
          showLoading(context);
        } else if (state.isSuccessLogout) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      builder: (context, state) {
        if (state.isSuccessGetProfile || state.isSuccessGetPosts) {
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
                        child: state.user?.picUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(72 * 0.5),
                                child: Image.network(
                                  state.user!.picUrl!,
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
                          '@${state.user?.username}',
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
                                Text('${state.posts?.length}'),
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
                                Text('${state.user?.followee.length}'),
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
                                Text('${state.user?.following.length}'),
                                const SizedBox(height: 4),
                                const Text('following'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isCurrentUser
                            ? SocButton(
                                width: 80,
                                height: 30,
                                onPressed: () {
                                  getIt<ProfileCubit>().logout();
                                },
                                color: Colors.red.shade300,
                                label: 'logout',
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                ),
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
        return Container();
      },
    );
  }
}
