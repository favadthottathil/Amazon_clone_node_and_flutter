import 'dart:convert';
import 'dart:developer';
import 'package:amazon_clone_with_nodejs/Constants/error_handling.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/orders.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountService {
  // FETCH ALL ORDERS
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Order> orderedList = [];

    try {
      var res = await http.get(
        Uri.parse('$apiEndpoint/api/orders/me'),
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

          print(items);

          orderedList = items
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

    return orderedList;
  }
}
