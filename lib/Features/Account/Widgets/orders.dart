import 'package:amazon_clone_with_nodejs/Common/Widgets/loader.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Features/Account/Service/account_service.dart';
import 'package:amazon_clone_with_nodejs/Features/Account/Widgets/single_product.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/orders.dart';
import 'package:amazon_clone_with_nodejs/Features/Order%20Details/Screens/order_detail_screen.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;

  final AccountService _accountService = AccountService();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  fetchOrders() async {
    orders = await _accountService.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        OrderDetailsScreen.routeName,
                        arguments: orders![index],
                      ),
                      child: SingleProduct(
                        image: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
