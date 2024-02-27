import 'package:amazon_clone_with_nodejs/Features/Admin/Bar%20Graph/individual_graph.dart';
import 'package:amazon_clone_with_nodejs/Features/Admin/Model/sales.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryProductChart extends StatefulWidget {
  final List<Sales> sales;
  const CategoryProductChart({super.key, required this.sales});

  @override
  State<CategoryProductChart> createState() => _CategoryProductChartState();
}

class _CategoryProductChartState extends State<CategoryProductChart> {
  List<BarChartGroupData> barChartGroupData = [];
  List<IndividualBar> barData = [];

  int maxSale = 0;

  @override
  void initState() {
    super.initState();
    initBarData();
  }

  initBarData() {
    for (var sale in widget.sales) {
      if (sale.earning > maxSale) {
        maxSale = sale.earning + 100;
      }
    }

    barData = [
      IndividualBar(x: 0, y: widget.sales[0].earning.toDouble()),
      IndividualBar(x: 1, y: widget.sales[1].earning.toDouble()),
      IndividualBar(x: 2, y: widget.sales[2].earning.toDouble()),
      IndividualBar(x: 3, y: widget.sales[3].earning.toDouble()),
      IndividualBar(x: 4, y: widget.sales[4].earning.toDouble()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BarChart(
        BarChartData(
          maxY: maxSale.toDouble(),
          minY: 0,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
              interval: 10,
              reservedSize: 25,
            )),
          ),
          barGroups: barData
              .map(
                (data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[900],
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxSale.toDouble(),
                      color: Colors.grey[200],
                    ),
                  )
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text(widget.sales[0].label.toString(), style: style, overflow: TextOverflow.ellipsis);

        break;
      case 1:
        text = Text(widget.sales[1].label, style: style, overflow: TextOverflow.ellipsis);

        break;
      case 2:
        text = Text(widget.sales[2].label, style: style, overflow: TextOverflow.ellipsis);

        break;
      case 3:
        text = Text(widget.sales[3].label, style: style, overflow: TextOverflow.ellipsis);

        break;
      case 4:
        text = Text(widget.sales[4].label, style: style, overflow: TextOverflow.ellipsis);

        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: SizedBox(
        width: 45,
        child: text,
      ),
    );
  }
}
