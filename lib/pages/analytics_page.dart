import 'package:flutter/material.dart';
import 'package:hook/widgets/pie_chart.dart';


class AnalyticsPage extends StatefulWidget {
  final String backgroundImage;

  const AnalyticsPage({Key? key, required this.backgroundImage}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int overallValue = 69;
  int totalEmailsSent = 0;
  int totalLinksClicked = 0;
  int clickThroughRate = 0;

  Color _getColorForValue(int overallValue) {
    if (overallValue >= 80) {
      return Colors.green;
    } else if (overallValue >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color circleColor = _getColorForValue(overallValue);

    return Container(
      height: 750,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Text(
                    'Overall',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$overallValue',
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2.0,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildStatWidget('Total Emails Sent', totalEmailsSent), 
                    ),
                    Container(
                      height: 200.0,
                      width: 2.0,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: _buildStatWidget('Total Links Clicked', totalLinksClicked),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2.0,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( //change this to a percent_indicator
                      child: _buildStatWidget('Click Through Rate', clickThroughRate), //change to String so it can have a percentage
                    ),
                    Container(
                      height: 200.0,
                      width: 2.0,
                      color: Colors.grey[400],
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Clicks per Intensity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          MyPieChart(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2.0,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 20), 
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    ),
                    
                    onPressed: () {  },
                    child: const Text('Refresh', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }

  Widget _buildStatWidget(String title, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Container(
          width: 80.0,
          height: 80.0,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$value',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

