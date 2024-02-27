import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../test_emails.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'LOGGED IN AS: ' + user.email!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20), // Add some spacing between the text and the button
          ElevatedButton(
            onPressed: () {
              // Log a message to the debugger when the button is pressed
              // sendEmail();
              debugPrint('Button pressed!');
            },
            style: ElevatedButton.styleFrom(
              // Add a fixed size to make the button bigger
              minimumSize: Size(200, 60),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0), // Add padding to make the button bigger
              child: Text(
                'Your Button',
                style: TextStyle(fontSize: 18), // Optional: Adjust the font size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
