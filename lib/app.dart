import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soc_app/features/explore/presentation/cubits/detail_profile_post_cubit.dart';
import 'package:soc_app/features/explore/presentation/cubits/explore_cubit.dart';
import 'package:soc_app/features/explore/presentation/pages/explore_page.dart';
import 'package:soc_app/features/post/presentation/cubits/post_cubit.dart';
import 'package:soc_app/features/post/presentation/page/create_post_page.dart';
import 'package:soc_app/features/profile/registration/presentation/cubit/profile_cubit.dart';
import 'package:soc_app/features/profile/registration/presentation/pages/user_profile_page.dart';
import 'package:soc_app/features/your_page/presentation/pages/your_page.dart';

import 'core/di/service_locator.dart';
import 'features/explore/presentation/cubits/follow_unfollow_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int _indexPage = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  /// widget list
  final List<Widget> bottomBarPages = const [
    YourPage(),
    CreatePostPage(),
    ExplorePage(),
    UserProfilePage(),
  ];

  int maxCount = 4;
  @override
  Widget build(BuildContext context) {
    // return StartupPage();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<PostCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<ExploreCubit>()..getUsers(),
          ),
          // provide the detail user here
          // because will cause concurrency issue if
          // we put the provider in detail user page
          // when re enter the page.
          BlocProvider(
            create: (context) => getIt<DetailProfilePostCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<FollowUnfollowCubit>(),
          ),
        ],
        child: IndexedStack(
          // controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          index: _indexPage,
          children: bottomBarPages,
        ),
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.black54,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.post_add,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.post_add,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),

                ///svg example
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person_2_outlined,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 4',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                // _pageController.jumpToPage(index);
                setState(() {
                  _indexPage = index;
                });
              },
            )
          : const SizedBox(
              child: Center(
                child: Text('asdasd'),
              ),
            ),
    );
  }
}
