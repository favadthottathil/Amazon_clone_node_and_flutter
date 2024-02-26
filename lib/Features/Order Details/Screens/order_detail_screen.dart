import 'package:amazon_clone_with_nodejs/Common/Widgets/custom_button.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Services/admin_services.dart';
import 'package:amazon_clone_with_nodejs/Features/Models/orders.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:amazon_clone_with_nodejs/Features/Search/Screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = '/order-details';
  const OrderDetailsScreen({super.key, required this.order});

  final Order order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;

  final AdminServices _adminServices = AdminServices();

  navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQuery,
    );
  }

  updateOrderStatus(int status) {
    _adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: (searrchQuery) => navigateToSearchScreen(searrchQuery),
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View order details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date:     ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt),
                    )}'),
                    Text('Order Id:          ${widget.order.id}'),
                    Text('Order Total:    \$${widget.order.totalPrice}'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Purchase details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var product in widget.order.products)
                      Row(
                        children: [
                          Image.network(
                            product.images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Text('Qty: ${product.quantity}')
                            ],
                          )),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (userProvider.user.type == 'admin') {
                      return CustomButton(
                        text: 'Done',
                        onpressed: () => updateOrderStatus(details.currentStep),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text('Your order is yet to be delivered'),
                      isActive: currentStep > 0,
                      state: currentStep > 0 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text('Your order has been delivered, you are yet to sign.'),
                      isActive: currentStep > 1,
                      state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text('Your order has been delivered and signed by you.'),
                      isActive: currentStep > 2,
                      state: currentStep > 2 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text('Your order has been delivered and signed by you.'),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3 ? StepState.complete : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
