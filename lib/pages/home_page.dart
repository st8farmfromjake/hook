import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../test_emails.dart';

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
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        //^^WILL REMOVE WHEN ACCOUNT INFO PAGE IS DONE
        body: SizedBox.expand(
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                _page = index;
              });
            },
            children: [
              //replace with pages
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.purple,
              ),
              Container(
                color: Colors.black,
              ),
            ],
          ),
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
              Icons.settings,
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
              child: Text('go to page'),
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
