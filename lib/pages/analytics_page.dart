// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hook/test_firestore.dart';
import 'package:hook/widgets/background-image.dart';
import 'package:hook/widgets/pie_chart.dart'; 
import 'package:hook/api_service.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>{
  int emailsSent = 0;
  int linksClicked = 0;
  bool isLoading = false;  // State to manage loading indicator
  String errorMessage = '';  // Error message display
  final int maxEmailsExpected = 50;  // Maximum expected emails

  @override
  void initState() {
      super.initState();
      getLinkData(); // This will fetch data when the widget is first created and inserted into the tree.
  }


  double computeOverallScore() {
    double normalizedEmailsSent = (emailsSent / maxEmailsExpected) * 100;
    double currentCTR = emailsSent > 0 ? (linksClicked / emailsSent) : 0;
    double ctrNorm = (1 - currentCTR) * 100;
    double overallScore = (0.2 * normalizedEmailsSent) + (0.8 * ctrNorm);
    return overallScore.clamp(0, 100);  // Ensure the score is between 0 and 100
  }
  
  void getLinkData() async {
    if (!mounted) return;  // Check if the widget is still mounted
    setState(() {
      isLoading = true;  // Start loading
      errorMessage = '';  // Clear previous errors
    });

    try {
      List<dynamic> documentData = await fetchDocument();
      if (!mounted) return;  // Check again after the asynchronous gap
      if (documentData.isNotEmpty) {
        String linkId = documentData[1];
        int emails = documentData[2];
        int linkClicks = await ApiService().getTotalClicks(linkId);

        if (!mounted) return;  // Check again after another asynchronous gap
        setState(() {
          emailsSent = emails;
          linksClicked = linkClicks;
          isLoading = false;  // Stop loading
        });

      } else {
        if (!mounted) return;
        setState(() {
          isLoading = false;
          errorMessage = "No data found in document!";  // Set error message
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = e.toString();  // Set error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double overallScore = computeOverallScore();
    Color circleColor = getScoreColor(overallScore);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(), // Ensure this widget exists and works similarly to ProfilePage
          Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : buildContent(circleColor, overallScore),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget buildContent(Color circleColor, double overallScore) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (errorMessage.isNotEmpty)  // Display an error message if any
            Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)),
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
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 180.0,
              height: 180.0,
              decoration:  BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  overallScore.toStringAsFixed(2),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildStatCircle('Total Emails\nSent', '$emailsSent'),
              Container(
                  height: 150.0,
                  width: 2.0,
                  color: Colors.grey[400],
                ),
              buildStatCircle('Total Links\nClicked', '$linksClicked'),
            ],
          ),
          const SizedBox(height: 20),
          buildRefreshButton(),
        ],
      ),
    );
  }

  Widget buildStatCircle(String title, String value) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,  // Reduced font size for better fitting
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),
      Container(
        width: 120.0,
        height: 90.0,
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain, // Ensures that the text scales down to fit into the available space
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Padding to prevent text from touching the edges
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 30, // Initial font size
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget buildRefreshButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.all(16),
        ),
        onPressed: getLinkData,  // Direct reference to the data fetch method
        child: const Text(
          'Refresh Data',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Color getScoreColor(double score) {
    if (score < 20) {
      return Colors.red;
    } else if (score < 40) {
      return Colors.orange;
    } else if (score < 60) {
      return Colors.yellow;
    } else if (score < 80) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }
}


// // ignore_for_file: file_names

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:hook/test_firestore.dart';
// import 'package:hook/widgets/pie_chart.dart'; 
// import 'package:hook/api_service.dart';


// class AnalyticsPage extends StatefulWidget {
//   const AnalyticsPage({Key? key});
  

//   @override
//   State<AnalyticsPage> createState() => _AnalyticsPageState();
// }
//   class _AnalyticsPageState extends State<AnalyticsPage>{
//     int emailsSent = 0;
//     int linksClicked = 0;
//     bool isLoading = false;  // State to manage loading indicator
//     String errorMessage = '';  // Error message display
//     final int maxEmailsExpected = 50;  // Maximum expected emails

//     double computeOverallScore() {
//       double normalizedEmailsSent = (emailsSent / maxEmailsExpected) * 100;
//       double currentCTR = emailsSent > 0 ? (linksClicked / emailsSent) : 0;
//       double ctrNorm = (1 - currentCTR) * 100;

//       double overallScore = (0.2 * normalizedEmailsSent) + (0.8 * ctrNorm);
//       return overallScore.clamp(0, 100);  // Ensure the score is between 0 and 100
//     }
    
//     void getLinkData() async {
//       if (!mounted) return;  // Check if the widget is still mounted
//       setState(() {
//         isLoading = true;  // Start loading
//         errorMessage = '';  // Clear previous errors
//       });

//       try {
//         List<dynamic> documentData = await fetchDocument();
//         if (!mounted) return;  // Check again after the asynchronous gap
//         if (documentData.isNotEmpty) {
//           String linkId = documentData[1];
//           int emails = documentData[2];
//           int linkClicks = await ApiService().getTotalClicks(linkId);

//           if (!mounted) return;  // Check again after another asynchronous gap
//           setState(() {
//             emailsSent = emails;
//             linksClicked = linkClicks;
//             isLoading = false;  // Stop loading
//           });

//           print('Path: ${documentData[0]}');
//           print('LinkID: $linkId');
//           print('Total Emails Sent: $emails');
//           print('Total Links Clicked: $linksClicked');
//         } else {
//           if (!mounted) return;
//           setState(() {
//             isLoading = false;
//             errorMessage = "No data found in document!";  // Set error message
//           });
//         }
//       } catch (e) {
//         if (!mounted) return;
//         setState(() {
//           isLoading = false;
//           errorMessage = e.toString();  // Set error message
//         });
//         print("Error getting data: $e");
//       }
//     }


  
//     Color getScoreColor(double score) {
//       if (score < 20) {
//         return Colors.red;  // Very low scores, blue
//       } else if (score < 40) {
//         return Colors.orange;  // Low scores, cyan
//       } else if (score < 60) {
//         return Colors.yellow;  // Medium scores, green
//       } else if (score < 80) {
//         return Colors.blue;  // High scores, yellow
//       } else {
//         return Colors.green;  // Very high scores, red
//       }
//     }
    
//     Timer? timer;

//     @override
//     void initState() {
//         super.initState();
//         // Removed getLinkData() from here to stop automatic fetching.
//     }

//     @override
//     void dispose() {
//       timer?.cancel();  // Cancel the timer when disposing the widget
//       super.dispose();
//     }

//     Widget buildContent(Color circleColor, double overallScore) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[ // Display the loading indicator when fetching data
//           if (errorMessage.isNotEmpty)  // Display an error message if any
//             Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)),
//             const Center(
//               child: Text(
//                 'Overall',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Center(
//               child: Container(
//                 width: 180.0,
//                 height: 180.0,
//                 decoration:  BoxDecoration(
//                   color: circleColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child:  Center(
//                   child: Text(
//                     overallScore.toStringAsFixed(2),
//                     style: const TextStyle(
//                       fontSize: 50,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 2.0,
//               width: double.infinity,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center, // Add this
//                     children: [
//                       const Text(
//                         'Total Emails Sent',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold, // Add this for uniformity
//                         ),
//                         textAlign: TextAlign.center, // Center the text
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         width: 90.0,
//                         height: 90.0,
//                         decoration: const BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '$emailsSent',
//                             style: const TextStyle(
//                               fontSize: 20, // Adjusted size
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center, // Center the text
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 200.0,
//                   width: 2.0,
//                   color: Colors.grey[400],
//                 ),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center, // Add this
//                     children: [
//                       const Text(
//                         'Total Links Clicked',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold, // Adjust for uniformity
//                         ),
//                         textAlign: TextAlign.center, // Center the text
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         width: 90.0,
//                         height: 90.0,
//                         decoration: const BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '$linksClicked',
//                             style: const TextStyle(
//                               fontSize: 25, // Adjusted size
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center, // Center the text
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 2.0,
//               width: double.infinity,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 20),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Expanded(
//                 //   child: Column(
//                 //     mainAxisAlignment: MainAxisAlignment.center, // Add this
//                 //     children: [
//                 //       const Text(
//                 //         'Click Through Rate',
//                 //         style: TextStyle(
//                 //           color: Colors.white,
//                 //           fontSize: 25, // Adjusted size
//                 //           fontWeight: FontWeight.bold, // Add this for uniformity
//                 //         ),
//                 //         textAlign: TextAlign.center, // Center the text
//                 //       ),
//                 //       const SizedBox(height: 10),
//                 //       Container(
//                 //         width: 90.0,
//                 //         height: 90.0,
//                 //         decoration: const BoxDecoration(
//                 //           color: Colors.blue,
//                 //           shape: BoxShape.circle,
//                 //         ),
//                 //         child: Center(
//                 //           child: Text(
//                 //             '${emailsSent > 0 ? ((linksClicked / emailsSent) * 100).toStringAsFixed(2) : "0.00"}%',
//                 //             style: const TextStyle(
//                 //               fontSize: 25, // Adjusted size
//                 //               color: Colors.white,
//                 //               fontWeight: FontWeight.bold,
//                 //             ),
//                 //             textAlign: TextAlign.center, // Center the text
//                 //           ),
//                 //         ),
//                 //       )

//                 //     ],
//                 //   ),
//                 // ),
//                 // Container(
//                 //   height: 200.0,
//                 //   width: 2.0,
//                 //   color: Colors.grey[400],
//                 // ),
//                 // const Expanded(
//                 //   child: Column(
//                 //     mainAxisAlignment: MainAxisAlignment.center, // Add this
//                 //     children: [
//                 //       Text(
//                 //         'Clicks per Intensity',
//                 //         style: TextStyle(
//                 //           color: Colors.white,
//                 //           fontSize: 25, // Adjusted size
//                 //           fontWeight: FontWeight.bold, // Add this for uniformity
//                 //         ),
//                 //         textAlign: TextAlign.center, // Center the text
//                 //       ),
//                 //       SizedBox(height: 10),
//                 //       // Pie chart goes here
//                 //       MyPieChart(), // Ensure this widget is properly sized
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ),
//             // const SizedBox(height: 20),
//             // Container(
//             //   height: 2.0,
//             //   width: double.infinity,
//             //   color: Colors.grey[400],
//             // ),
//             buildRefreshButton(),  // Refresh button at the bottom  // Refresh button at the bottom
//           ],
//         );
//     }
  
//   @override
//   Widget build(BuildContext context) {
//     double overallScore = computeOverallScore();
//     Color circleColor = getScoreColor(overallScore);

//     return Container(
//       height: 750,
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/HookBG(1).jpg"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Stack(  // Use Stack to overlay the loader
//             children: [
//               SingleChildScrollView(  // Existing content
//                 child: buildContent(circleColor, overallScore),
//               ),
//               if (isLoading)
//                 Container(
//                   color: Colors.black.withOpacity(0.5),  // Semi-transparent black background
//                   alignment: Alignment.center,  // Center the spinner in the screen
//                   child: const CircularProgressIndicator(
//                     color: Colors.white,  // Set spinner color to white
//                   ),
//                 ),// Refresh button at the bottom, outside the loading overlay for continuous access
//             ],
//           ),
//         ),
//       )
//     );
//   }

//   Widget buildRefreshButton() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextButton(
//         style: TextButton.styleFrom(
//           backgroundColor: Colors.orange,
//           padding: const EdgeInsets.all(16),
//         ),
//         onPressed: getLinkData,  // Direct reference to the data fetch method
//         child: const Text(
//           'Refresh Data',
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//       ),
//     );
//   }
// }