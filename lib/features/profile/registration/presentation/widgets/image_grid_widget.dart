import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/core/di/service_locator.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';

class ImageGridWidget extends StatelessWidget {
  const ImageGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 3) - 1;
    double height = (MediaQuery.of(context).size.width / 3) - 1;
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      builder: (context, state) {
        if (state.isSuccessGetPosts) {
          if (state.posts == []) {
            return Container();
          }
          return Wrap(
            spacing: 1,
            runSpacing: 1,
            direction: Axis.horizontal,
            children: List.generate(
              state.posts!.length,
              (index) => Container(
                height: height,
                width: width,
                color: Colors.grey.shade400,
                child: Image.network(
                  state.posts![index].postPic,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
