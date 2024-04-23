// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hook/widgets/pie_chart.dart';
import 'package:hook/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key, required String backgroundImage});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int overallValue = 69;
  int emailsSent = 10;
  int clickThroughRate = 0;
  int linksClicked = ApiService.getCachedLinksClicked();

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
  void initState() {
    super.initState();
    refreshLinksClicked();
  }

  void refreshLinksClicked() async {
    await ApiService().getTotalClicks();
    // stuff goes here
    setState(() {
      linksClicked = ApiService.getCachedLinksClicked();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color circleColor = _getColorForValue(overallValue);
    return Container(
      height: 750,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/HookBG(1).jpg"),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Add this
                        children: [
                          const Text(
                            'Total Emails Sent',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight:
                                  FontWeight.bold, // Add this for uniformity
                            ),
                            textAlign: TextAlign.center, // Center the text
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
                                '$emailsSent',
                                style: const TextStyle(
                                  fontSize: 20, // Adjusted size
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center, // Center the text
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200.0,
                      width: 2.0,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Add this
                        children: [
                          const Text(
                            'Total Links Clicked',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight:
                                  FontWeight.bold, // Adjust for uniformity
                            ),
                            textAlign: TextAlign.center, // Center the text
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
                                '$linksClicked',
                                style: const TextStyle(
                                  fontSize: 25, // Adjusted size
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center, // Center the text
                              ),
                            ),
                          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Click Through Rate',
                            style: TextStyle(
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
                            child: const Center(
                              child: Text(
                                '0%',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200.0,
                      width: 2.0,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white, // Text Color
                              backgroundColor:
                                  Colors.orange, // Button background color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 16.0),
                            ),
                            onPressed:
                                refreshLinksClicked, // Link to a refresh method
                            child: const Text('Refresh',
                                style: TextStyle(fontSize: 20)),
                          ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
