import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:soc_app/features/explore/presentation/cubits/explore_cubit.dart';
import 'package:soc_app/features/explore/presentation/pages/detail_user_page.dart';
import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';
import 'package:soc_app/widgets/neu_container.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String currentUserId = '';
  @override
  void initState() {
    super.initState();
    // we need to get the current userId
    // so we can map whether we are in followee || followers
    // or not
    setUserId();
  }

  void setUserId() async {
    var box = await Hive.openBox('userStatus');
    currentUserId = box.get('userUid');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        if (state.isSuccess) {
          return SingleChildScrollView(
            child: Column(
                children: List.generate(state.users!.length, (index) {
              return _PeopleList(
                state.users![index],
                index == state.users!.length - 1,
                index == 0,
                currentUserId,
              );
            })),
          );
        }
        return Container();
      },
    );
  }
}

class _PeopleList extends StatelessWidget {
  const _PeopleList(
    this.user,
    this.isLast,
    this.isFirst,
    this.currentUserId,
  );
  final SocUser user;
  final bool isLast;
  final bool isFirst;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailUserPage(user)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        margin: isLast
            ? const EdgeInsets.only(bottom: 80, top: 4)
            : isFirst
                ? const EdgeInsets.only(bottom: 4, top: 28)
                : const EdgeInsets.symmetric(vertical: 4),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('@${user.username}'),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 18,
                  ),
                  // add additional margin when it is the last or first item
                  child: NeuContainer(
                    backgroundColor: Colors.white,
                    child: user.isInFollowing(currentUserId)
                        ? const Text('unfollow')
                        : const Text('follow'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
