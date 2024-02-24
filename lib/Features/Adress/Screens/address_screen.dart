import 'package:amazon_clone_with_nodejs/Common/Widgets/custom_button.dart';
import 'package:amazon_clone_with_nodejs/Common/Widgets/custom_textfield.dart';
import 'package:amazon_clone_with_nodejs/Constants/global_variables.dart';
import 'package:amazon_clone_with_nodejs/Constants/utilities.dart';
import 'package:amazon_clone_with_nodejs/Features/Adress/Services/address_service.dart';
import 'package:amazon_clone_with_nodejs/Features/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddresScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddresScreen({super.key, required this.totalAmount});

  @override
  State<AddresScreen> createState() => _AddresScreenState();
}

class _AddresScreenState extends State<AddresScreen> {
  final _formKey = GlobalKey<FormState>();

  final flatBuidingController = TextEditingController();
  final areaController = TextEditingController();
  final pinController = TextEditingController();
  final cityController = TextEditingController();

  final AddressServices _addressServices = AddressServices();

  String addressTobeUsed = '';

  List<PaymentItem> paymentItems = [];

  void onPaymentResult() {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      _addressServices.saveUserAddress(context: context, address: addressTobeUsed);
    }

    _addressServices.placeOrder(
      context: context,
      address: addressTobeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressTobeUsed = '';

    bool isForm = flatBuidingController.text.isNotEmpty || areaController.text.isNotEmpty || areaController.text.isNotEmpty || pinController.text.isNotEmpty || cityController.text.isNotEmpty;

    if (isForm) {
      if (_formKey.currentState!.validate()) {
        addressTobeUsed = '${flatBuidingController.text}, ${areaController.text}, ${cityController.text} - ${pinController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressTobeUsed = addressFromProvider;
    } else {
      showSnackbar(context, 'ERROR');
    }
  }

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Text(
                      address,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'OR',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: flatBuidingController,
                    hintText: 'Flat, House no, Building',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: areaController,
                    hintText: 'Area, Street',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: pinController,
                    hintText: 'Pincode',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: cityController,
                    hintText: 'Town/City',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // GooglePayButton(
            //   onPressed: () => payPressed(address),
            //   onPaymentResult: onPaymentResult,
            //   width: double.infinity,
            //   type: GooglePayButtonType.buy,
            //   paymentItems: paymentItems,
            //   paymentConfigurationAsset: 'gpay.json',
            //   loadingIndicator: const Center(child: CircularProgressIndicator()),
            // ),
            const SizedBox(height: 40),
            CustomButton(
                text: 'Buy Now',
                onpressed: () {
                  payPressed(address);
                  onPaymentResult();
                })
          ],
        ),
      ),
    );
  }
}
