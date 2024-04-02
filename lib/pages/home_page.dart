import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hook/pages/analytics_page.dart';
import 'package:hook/palette.dart';
import 'package:flutter/material.dart';
import '../pages/email_page.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  //FIREBASE ^^^

  //ROUTE INDEX
  int _page = 0;

//controller
  final controller = PageController(initialPage: 0);

  //IMPORTANT FOR SIGN OUT
  //WILL PUT ACCOUNT INFO ON A SEPERATE PAGE AND HAVE SIGN OUT BUTTON WHICH WILL USE...
  //... the below function

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // @override
  // void initState(){
  //   super.initState();
  //   _pageController = PageController();
  // }

  // @override
  // void dispose(){
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //WILL REMOVE THE APP BAR ONCE ACCOUNT INFO PAGE IS DONE
        //^^WILL REMOVE WHEN ACCOUNT INFO PAGE IS DONE
        body: Stack(
          children: [
            const BackgroundImage(),
            SizedBox.expand(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    _page = index;
                  });
                },
                children: [
                  //replace with pages
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // To keep the column's size just as big as its children need.
                      children: [
                        const Text(
                          '\n<º)))><\nHook',
                          style: kHeading,
                          textAlign: TextAlign
                              .center, // Center align the text if kHeading doesn't already do so.
                        ),
                        const SizedBox(
                            height:
                                16), // Space between the two texts. Adjust the size as needed.
                        const Text(
                          "Test your employees. Improve your scam-awareness. Bolster your security.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign
                              .center, // Ensures text alignment is centered.
                        ),
                        Container(
                          width: 225,
                          height: 75,
                          margin: const EdgeInsets.only(
                              top: 50, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => setState(() {
                                controller.jumpToPage(2);
                              }),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  'Configure Email',
                                  style: kBodyButtonText,
                                ),
                              )),
                        ),
                        Container(
                          width: 225,
                          height: 75,
                          margin: const EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => setState(() {
                                controller.jumpToPage(1);
                              }),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  'View Report',
                                  style: kBodyButtonText,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),

                  const AnalyticsPage(),

                  const EmailPage(),

                  Container(
                    padding: const EdgeInsets.all(30),
                    child: const Column(
                      mainAxisSize: MainAxisSize
                          .min, // To keep the column as compact as possible.
                      children: [
                        Text(
                          'Profile',
                          style: kHeading,
                          textAlign: TextAlign
                              .center, // Center align the text if kHeading doesn't already do so.
                        ),
                        // Add other widgets below as needed.
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Keeps the column compact.
                      children: [
                        const SizedBox(
                            height:
                                200),
                        const Text(
                          'Are you sure you want to sign out?',
                          style: kHeading,
                          textAlign: TextAlign.center, // Centers the text.
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        IconButton(
                          onPressed: signUserOut,
                          icon: const Icon(Icons.logout),
                          color: Colors.white,
                          iconSize: 100,
                        ),
                        const SizedBox(
                            height:
                                20), // Adds spacing between the icon button and the text.
                        // You can add more widgets here as needed.
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: _page,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.orange,
          color: Colors.orange,
          animationDuration: const Duration(milliseconds: 300),
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.analytics,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.logout,
              size: 26,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              controller.jumpToPage(index);
            });
          },
        ),
      ),
    );
    // Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Center(
    //             child: Text(
    //               'LOGGED IN AS: ' + user.email!,
    //               style: const TextStyle(fontSize: 20),
    //             ),
    //           ),
    //           const SizedBox(
    //               height: 20), // Add some spacing between the text and the button
    //           ElevatedButton(
    //             onPressed: () {
    //               // Log a message to the debugger when the button is pressed
    //               sendEmail();
    //               debugPrint('Button pressed!');
    //             },
    //             style: ElevatedButton.styleFrom(
    //               // Add a fixed size to make the button bigger
    //               minimumSize: Size(200, 60),
    //             ),
    //             child: const Padding(
    //               padding: EdgeInsets.all(
    //                   12.0), // Add padding to make the button bigger
    //               child: Text(
    //                 'Your Button',
    //                 style:
    //                     TextStyle(fontSize: 18), // Optional: Adjust the font size
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
  }
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({Key? key, required this.tab}) : super(key: key);

  //JUST FOR DEMO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tab $tab')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab $tab'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Page(tab: tab),
                ));
              },
              child: const Text('go to page'),
            )
          ],
        ),
      ),
    );
  }
}

//FOR THE DEMO
class Page extends StatelessWidget {
  final int tab;
  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Tab $tab'),
      ),
      body: Center(
        child: Text('Tab $tab'),
      ),
    );
  }
}
