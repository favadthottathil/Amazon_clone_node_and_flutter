import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone_with_nodejs/Constants/error_handling.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Model/sales.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/orders.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/product.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinery = CloudinaryPublic('dottlfwim', 'oy2tywma');

      List<String> imageUrls = [];

      for (var image in images) {
        CloudinaryResponse res = await cloudinery.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: name),
        );

        imageUrls.add(res.secureUrl);
      }

      print(imageUrls);

      final product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      final res = await http.post(
        Uri.parse('$apiEndpoint/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // Get All Products

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Product> productList = [];

    try {
      var res = await http.get(
        Uri.parse('$apiEndpoint/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List items = jsonDecode(res.body);

          productList = items
              .map(
                (item) => Product.fromJson(
                  jsonEncode(item),
                ),
              )
              .toList();
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
      log(e.toString());
    }

    return productList;
  }

  // Delete Product

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final res = await http.post(
        Uri.parse('$apiEndpoint/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackbar(context, 'Product Deleted Successfully!');
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // FETCH ALL ORDERS

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Order> orderList = [];

    try {
      var res = await http.get(
        Uri.parse('$apiEndpoint/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List items = jsonDecode(res.body);

          orderList = items
              .map(
                (item) => Order.fromJson(
                  jsonEncode(item),
                ),
              )
              .toList();
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
      log(e.toString());
    }

    return orderList;
  }

  // Change Order Status

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final res = await http.post(
        Uri.parse('$apiEndpoint/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // get all analytics

  Future<Map<String, dynamic>> fetchAllAnalytics(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Sales> sales = [];

    int totalEarinings = 0;

    try {
      var res = await http.get(
        Uri.parse('$apiEndpoint/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var items = jsonDecode(res.body);

          totalEarinings = items['toatalEarings'];

          sales = [
            Sales('Mobiles', items['mobileEarnings']),
            Sales('Essentials', items['essentialsEarnings']),
            Sales('Appliances', items['appliancesEarnings']),
            Sales('Books', items['booksEarnings']),
            Sales('Fashion', items['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
      log(e.toString());
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarinings,
    };
  }
}
