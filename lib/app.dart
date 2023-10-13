import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:soc_app/features/profile/registration/presentation/login_page.dart';
import 'package:soc_app/features/profile/registration/presentation/register_page.dart';
import 'package:soc_app/features/your_page/presentation/pages/your_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    print('object');
    super.initState();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    YourPage(),
    Container(child: Text('2')),
    Container(child: Text('3')),
    RegisterPage(),
  ];

  int maxCount = 4;
  @override
  Widget build(BuildContext context) {
    // return LoginPage();
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            bottomBarPages.length,
            (index) => bottomBarPages[index],
          ),
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
                print('current selected index $index');
                _pageController.jumpToPage(index);
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
