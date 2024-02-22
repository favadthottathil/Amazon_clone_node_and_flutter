import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Features/Account/Screens/account_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Cart/Screens/cart_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/home_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void updatePage(int value) {
    setState(() {
      page = value;
    });
  }

  List<Widget> pages = const [
    HomeScreen(),
    AccountScreen(),
    CartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final cartLength = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 0 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          // ACCOUNT
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 1 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ''),
          // CART
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 2 ? GlobalVariables.selectedNavBarColor : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: badges.Badge(
                  badgeContent: Text(cartLength.toString()),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.white,
                  ),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
              label: ''),
        ],
      ),
    );
  }
}
