import 'dart:convert';

import 'package:amazon_clone_with_nodejs/Constants/error_handling.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/product.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  // Get All Products

  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Product> productList = [];

    try {
      var res = await http.get(
        Uri.parse('$apiEndpoint/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

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
    }

    return productList;
  }
}
