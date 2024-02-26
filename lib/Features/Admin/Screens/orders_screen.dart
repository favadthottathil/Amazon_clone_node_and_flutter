import 'package:amazon_clone_with_nodejs/Common/Widgets/loader.dart';
import 'package:amazon_clone_with_nodejs/Features/Account/Widgets/single_product.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Services/admin_services.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/orders.dart';
import 'package:amazon_clone_with_nodejs/Features/Order%20Details/Screens/order_detail_screen.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;

  final AdminServices _adminServices = AdminServices();

  fetchAllOrders() async {
    orders = await _adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            itemBuilder: (BuildContext context, int index) {
              final order = orders![index];

              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  OrderDetailsScreen.routeName,
                  arguments: order,
                ),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: order.products[0].images[0],
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          );
  }
}
