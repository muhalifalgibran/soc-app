import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/login_cubit.dart';
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
    return BlocListener<ProfileCubit, ProfileState>(
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
      child: Container(
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
                            onPressed: () {
                              getIt<ProfileCubit>().logout();
                            },
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
      ),
    );
  }
}
