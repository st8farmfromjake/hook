import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming you want to match the pie chart size with the "Click Through Rate" circle which is 60x60
    double size = 80.0; // The desired size for the pie chart
    double radius = size / 2; // Half of the size to use as the radius for the pie chart sections

    return Container(
      width: size, // Specify the width of the Container
      height: size, // Specify the height of the Container
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0, // Adjust this value if you want a space in the middle of the pie chart
          sectionsSpace: 0, // Adjust if you want spacing between sections
          sections: [
            PieChartSectionData(
              value: 20,
              color: Colors.green,
              radius: radius, // Use the calculated radius
            ),
            PieChartSectionData(
              value: 50,
              color: Colors.orange,
              radius: radius,
            ),
            PieChartSectionData(
              value: 20,
              color: Colors.red,
              radius: radius,
            ),
            PieChartSectionData(
              value: 20,
              color: Colors.brown,
              radius: radius,
            ),
          ],
        ),
        swapAnimationDuration: const Duration(milliseconds: 750), // Animation duration
      ),
    );
  }
}
