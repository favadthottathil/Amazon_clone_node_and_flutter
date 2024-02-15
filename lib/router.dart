import 'package:amazon_clone_with_nodejs/Common/Widgets/bottom_bar.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Screens/add_product_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/category_deals_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddProductScreen(),
      );
    case CategoryDealScreen.routeName:
      final category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => CategoryDealScreen(category: category),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Screen Doesnt Exist')),
        ),
      );
  }
}
