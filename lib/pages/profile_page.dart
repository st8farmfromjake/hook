import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:hook/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
  final User user = FirebaseAuth.instance.currentUser!;
  String displayName = user.displayName.toString();
  String email = user.email.toString();

    return Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SizedBox.expand(
              child: PageView(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/pfp.jpg'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          displayName,
                          style: kBodyText
                        ), 
                        const SizedBox(
                          height: 10,
                        ),  
                        Text(
                          email,
                          style: kEmailText,
                        ),  
                        const SizedBox(
                          height: 50,
                        ),  
                        Container(
                          width: 350,
                          height:50,
                          margin: const EdgeInsets.only(top:20, left:20, right:20),
                          decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Configure Display Name'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  scrollable: true,
                                  content: const Text('''null'''),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('✓'),
                                    )
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Configure Display Name',
                                style: kProfileButton,
                              ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height:50,
                          margin: const EdgeInsets.only(top:20, left:20, right:20),
                          decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Configure Company Name'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  scrollable: true,
                                  content: const Text('''null'''),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('✓'),
                                    )
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Configure Company Name',
                                style: kProfileButton,
                              ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height:50,
                          margin: const EdgeInsets.only(top:20, left:20, right:20),
                          decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Configure Email'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  scrollable: true,
                                  content: const Text('''null'''),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('✓'),
                                    )
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Configure Email',
                                style: kProfileButton,
                              ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height:50,
                          margin: const EdgeInsets.only(top:20, left:20, right:20),
                          decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Reset Password'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  scrollable: true,
                                  content: const Text('''null'''),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('✓'),
                                    )
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Reset Password',
                                style: kProfileButton,
                              ),
                          ),
                        ),
                        Container(
                          width: 350,
                          height:50,
                          margin: const EdgeInsets.only(top:20, left:20, right:20),
                          decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(16)),
                          child: TextButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Terms of Service'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  scrollable: true,
                                  content: const Text('''                              <o))))><\n
Introduction\n
Welcome to Hook, a mobile app that allows users to test their fellow employees’ email-scam awareness. By using Hook, you agree to be bound by these terms of service, utilizing this application for professional well-intentioned purposes. No funny business.\n
Eligibility\n
To use Hook, you must be at least 13 years old.\n
Account Creation\n
In order to use Hook, you must create an account. When you create an account, you must provide us with your email address, and password. You are responsible for maintaining the confidentiality of your account information. You are also responsible for all activities that occur under your account.\n
Content\n
You are solely responsible for the content that you submit to Hook. You agree that you will not submit any content that is unlawful, offensive, or harmful. You also agree that you will not submit any content that infringes the intellectual property rights of others.\n
Termination\n
We may terminate your account at any time for any reason. If we terminate your account, you will no longer be able to access Hook. Womp womp…\n
Disclaimer\n
We make no representations or warranties about the accuracy, reliability, or completeness of the content on Hook. We are not responsible for any damages that you may suffer as a result of using Hook.\n
Governing Law\n
These terms of service are governed by the laws of the Florida Southern College.\n
Contact Us\n
If you have any questions about these terms of service, please contact us at support@hook.com (but don’t actually!).'''),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('✓'),
                                    )
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Terms of Service',
                                style: kProfileButton,
                              ),
                          ),
                        ),
                      ]
                    )
                  )
                ]
              )
            )
          ]
        )
    );
  }
}
