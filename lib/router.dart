import 'package:amazon_clone_with_nodejs/Common/Widgets/bottom_bar.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Screens/add_product_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Adress/Screens/address_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Auth/Screens/auth_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/category_deals_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Home/Screens/home_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/orders.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/product.dart';
import 'package:amazon_clone_with_nodejs/Features/Order%20Details/Screens/order_detail_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Product_details/Screens/product_detail_screen.dart';
import 'package:amazon_clone_with_nodejs/Features/Search/Screens/search_screen.dart';
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
    case SearchScreen.routeName:
      final searcyQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => SearchScreen(searchQuery: searcyQuery),
      );
    case ProductDetailsScreen.routeName:
      final product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      );
    case AddresScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => AddresScreen(totalAmount: totalAmount),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(order: order),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Screen Doesnt Exist')),
        ),
      );
  }
}
