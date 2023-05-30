import 'package:camera/camera.dart';
import 'package:firstgetx/widgets/antibug/antibug.dart';
import 'package:firstgetx/widgets/detect/detect.dart';
import 'package:firstgetx/widgets/home/home.dart';
import 'package:firstgetx/widgets/favorite/favorite.dart';
import 'package:firstgetx/widgets/setting/setting.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Favorite(),
    const Home(),
    const AntiBug(),
    const Setting()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: InkWell(
          onTap: () {
            setState(() {
              currentScreen = Detect(cameras: widget.cameras);
              currentTab = 4;
            });
          },
          child: const SizedBox(
              width: 72,
              height: 72,
              child: Image(
                image: AssetImage('assets/images/ic_detect.png'),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomNavigationBar);
  }

  Widget get bottomNavigationBar {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: -2,
              blurRadius: 10,
              offset: const Offset(-5, -5)),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: BottomAppBar(
          // shape: const CircularNotchedRectangle(),
          // notchMargin: 5,
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 31),
            decoration: const BoxDecoration(
                // color: Colors.amber[50],
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      currentScreen = Home();
                      currentTab = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: currentTab == 0 ? 0 : 4),
                    child: Image.asset(
                      'assets/images/ic_tab_home.png',
                      width: currentTab == 0 ? 36 : 28,
                      height: currentTab == 0 ? 36 : 28,
                      fit: BoxFit.contain,
                      color:
                          currentTab == 0 ? Colors.lightBlue : Colors.blueGrey,
                    ),
                  ),
                  // Icon(
                  //   Icons.home,
                  //   color: currentTab == 0 ? Colors.lightBlue : Colors.blueGrey,
                  //   size: currentTab == 0 ? 36 : 28,
                  // ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      currentScreen = const Favorite();
                      currentTab = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: currentTab == 1 ? 0 : 4),
                    child: SizedBox(
                      child: Image.asset(
                        'assets/images/ic_tab_favorite.png',
                        width: currentTab == 1 ? 36 : 28,
                        height: currentTab == 1 ? 36 : 28,
                        fit: BoxFit.contain,
                        color: currentTab == 1
                            ? Colors.lightBlue
                            : Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                  ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      currentScreen = const AntiBug();
                      currentTab = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: currentTab == 2 ? 0 : 4),
                    child: SizedBox(
                      child: Image.asset(
                        'assets/images/ic_tab_antibug.png',
                        width: currentTab == 2 ? 36 : 28,
                        height: currentTab == 2 ? 36 : 28,
                        fit: BoxFit.contain,
                        color: currentTab == 2
                            ? Colors.lightBlue
                            : Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  // color: Colors.greenAccent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      currentScreen = const Setting();
                      currentTab = 3;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: currentTab == 3 ? 0 : 4),
                    child: SizedBox(
                      child: Image.asset(
                        'assets/images/ic_tab_setting.png',
                        width: currentTab == 3 ? 36 : 28,
                        height: currentTab == 3 ? 36 : 28,
                        fit: BoxFit.contain,
                        color: currentTab == 3
                            ? Colors.lightBlue
                            : Colors.blueGrey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
