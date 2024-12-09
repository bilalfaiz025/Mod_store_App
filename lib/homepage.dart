import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Homepage/Profile.dart';
import 'package:untitled/Homepage/game.dart';


import 'Homepage/apk.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final _pageController = PageController(initialPage: 1);

  int maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [
    const gamescreen(),
    const apkscreen(),
    const profilescreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        pageController: _pageController,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.deepPurple,
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              CupertinoIcons.game_controller,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              CupertinoIcons.game_controller,
              color: Colors.white,
            ),
            itemLabel: 'Page 1',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.apps,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.apps,
              color: Colors.white,
            ),
            itemLabel: 'Page 2',
          ),

          ///svg example
          BottomBarItem(
            inActiveItem:  Icon(
              CupertinoIcons.profile_circled,
            ),
            activeItem: Icon(
              Icons.person,
              color: Colors.white,

            ),

            itemLabel: 'Page 3',
          ),
        ],
        onTap: (index) {
          /// control your animation using page controller
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
      )
          : null,
    );
  }
}
