import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';
import 'package:soc_app/features/profile/registration/presentation/pages/login_page.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/image_grid_widget.dart';
import 'package:soc_app/features/profile/registration/presentation/widgets/profile_header_widget.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ProfileCubit _profileCubit;

  void _getData() {
    _profileCubit.getPosts();
    _profileCubit.getProfile();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _profileCubit = context.read<ProfileCubit>();
        _getData();
      },
    );
  }

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
      bloc: context.read<ProfileCubit>(),
      listener: (context, state) {
        if (state.isLoadingLogout) {
          showLoading(context);
        } else if (state.isSuccessLogout) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
        setState(() {});
      },
      builder: (context, state) {
        if (state.isLoading) {
          return Container();
        }
        if (state.isSuccessGetPosts || state.isSuccessGetProfile) {
          return RefreshIndicator(
            onRefresh: () async {
              // _getData();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeadWidget(state.user, state.posts ?? []),
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
    );
  }
}
