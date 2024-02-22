import 'dart:convert';

import 'package:amazon_clone_with_nodejs/Constants/error_handling.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/product.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/user_model.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartService {
  removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final res = await http.delete(
        Uri.parse('$apiEndpoint/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserModel user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );

          userProvider.setUserFromModel(user);

          
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
