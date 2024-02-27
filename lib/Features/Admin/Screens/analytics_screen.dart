import 'package:amazon_clone_with_nodejs/Common/Widgets/loader.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Model/sales.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Services/admin_services.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Widgets/category_product_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices _adminServices = AdminServices();

  int? totalSales;

  List<Sales>? earings;

  getEarnings() async {
    var earningsData = await _adminServices.fetchAllAnalytics(context);

    totalSales = earningsData['totalEarnings'];
    earings = earningsData['sales'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: totalSales == null || earings == null
            ? const Loader()
            : Column(
                children: [
                  Text(
                    '\$$totalSales',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 300,
                    child: CategoryProductChart(sales: earings!),
                  ),
                ],
              ),
      ),
    );
  }
}
