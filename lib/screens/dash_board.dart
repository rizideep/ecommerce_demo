import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:prop_olx/screens/dashboard/account.dart';
import 'package:prop_olx/screens/dashboard/cart.dart';
import 'package:prop_olx/screens/dashboard/explore.dart';

import '../src/app_colors.dart';
import '../utils/util.dart';
import 'dashboard/home.dart';


class DashBoard extends StatefulWidget {
  var selectedIndex = 0;

  var willPopScreen = false;

  DashBoard({super.key});

  @override
  State<DashBoard> createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  List<Widget> list = [
    const Home(),
    const Explore(),
    const Cart(),
    const Account()
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: colorWhite, // Set the status bar color
        statusBarIconBrightness: Brightness.dark, // Adjust the icon brightness
      ),
      child: Scaffold(
        body: WillPopScope(
          onWillPop: onBackProcessed,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                LazyIndexedStack(
                  index: widget.selectedIndex,
                  children: list,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: getBottomNavigationBar(),
      ),
    );
  }

  getBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: 'Account'),
      ],
      onTap: (index) {
        setState(() {
          widget.selectedIndex = index;
        });
      },
      currentIndex: widget.selectedIndex,
      selectedItemColor: colorOrange,
      unselectedItemColor: textColorBlack,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  Future<bool> onBackProcessed() {
    if (!widget.willPopScreen) {
      MyUtil.showToast("Double Back to exit");
      widget.willPopScreen = true;
      Future.delayed(const Duration(seconds: 5), () {
        widget.willPopScreen = false;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
