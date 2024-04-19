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
String curImage = 'assets/pfp.jpg';

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
  final User user = FirebaseAuth.instance.currentUser!;
  String displayName = user.displayName.toString();
  String email = user.email.toString();

  var displayNameController = TextEditingController();
  var passwordController = TextEditingController();
  
    return Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SizedBox.expand(
              child: PageView(
                children: [
                  Center(
                    child: SingleChildScrollView(

                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: const Border.symmetric(
                              horizontal: BorderSide(
                                color: Colors.white,
                                width: 3
                              ),
                              vertical: BorderSide(
                                color: Colors.white,
                                width: 3
                              )
                            ),
                            image: DecorationImage(
                              image: AssetImage(curImage),
                              fit: BoxFit.fill
                            )
                          )
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
                                  content: TextFormField(
                                    decoration: const InputDecoration(hintText: "Username"),
                                    controller: displayNameController,
                                  ),  
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () async {

                                        var newDisplayName = displayNameController.text;
                                        user.updateDisplayName(newDisplayName);
                                        

                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      
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
                                  title: const Text('Configure Profile Picture'),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                  scrollable: true,
                                  content: Column(
                                    children: [
                                      Row(
                                      children: [
                                        SizedBox(
                                          height: 93,
                                          width: 93,
                                          child: IconButton(
                                            padding: const EdgeInsets.only(right:5),
                                            icon: Image.asset('assets/fish1.png'),
                                            iconSize: 20,
                                            onPressed: () {
                                              curImage = 'assets/fish1.png';
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          )
                                        ), 
                                        SizedBox(
                                          height: 93,
                                          width: 93,
                                          child: IconButton(
                                            padding: const EdgeInsets.only(right:5, left:5),
                                            icon: Image.asset('assets/fish2.png'),
                                            iconSize: 20,
                                            onPressed: () {
                                              curImage = 'assets/fish2.png';
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          )
                                        ),  
                                        SizedBox(
                                          height: 93,
                                          width: 93,
                                          child: IconButton(
                                            padding: const EdgeInsets.only(left:5),
                                            icon: Image.asset('assets/fish3.png'),
                                            iconSize: 20,
                                            onPressed: () {
                                              curImage = 'assets/fish3.png';
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          )
                                        ),   
                                      ]
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 93,
                                          width: 93,
                                          child: IconButton(
                                            padding: const EdgeInsets.only(right:5),
                                            icon: Image.asset('assets/fish4.png'),
                                            iconSize: 20,
                                            onPressed: () {
                                              curImage = 'assets/fish4.png';
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          )
                                        ),
                                        SizedBox(
                                          height: 93,
                                          width: 93,
                                          child: IconButton(
                                            padding: const EdgeInsets.only(left:5, right:5),
                                            icon: Image.asset('assets/fish5.png'),
                                            iconSize: 20,
                                            onPressed: () {
                                              curImage = 'assets/fish5.png';
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          )
                                        ),
                                        SizedBox(
                                          height: 93,
                                          width: 93,
                                          child: IconButton(
                                            padding: const EdgeInsets.only(left:5),
                                            icon: Image.asset('assets/fish6.jpg'),
                                            iconSize: 20,
                                            onPressed: () {
                                              curImage = 'assets/fish6.jpg';
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                          )
                                        ),
                                      ] 
                                    )
                                  ],
                                ),
                                
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () async {

                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: const Text('✓'),
                                    )
                                  ],
                                ),
                              ),
                              child: const Text(
                                'Configure Profile Picture',
                                style: kProfileButton,
                              ),
                          ),
                        ),
                        // Container(
                        //   width: 350,
                        //   height:50,
                        //   margin: const EdgeInsets.only(top:20, left:20, right:20),
                        //   decoration: BoxDecoration(
                        //   color: Colors.orange,
                        //   borderRadius: BorderRadius.circular(16)),
                        //   child: TextButton(
                        //       onPressed: () => showDialog(
                        //         context: context,
                        //         builder: (_) => AlertDialog(
                        //           title: const Text('Configure Email'),
                        //           shape: const RoundedRectangleBorder(
                        //               borderRadius:
                        //                   BorderRadius.all(Radius.circular(20))),
                        //           scrollable: true,
                        //           content: TextFormField(
                        //             decoration: const InputDecoration(hintText: "Email"),
                        //             controller: emailController,
                        //           ), 
                        //           actionsAlignment: MainAxisAlignment.center,
                        //           actions: [
                        //             OutlinedButton(
                        //               onPressed: () async {

                        //                 var newEmail = emailController.text;
                        //                 user.verifyBeforeUpdateEmail(newEmail);
                                        

                        //                 setState(() {});
                        //                 Navigator.pop(context);
                        //               },
                        //               child: const Text('✓'),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       child: const Text(
                        //         'Configure Email',
                        //         style: kProfileButton,
                        //       ),
                        //   ),
                        // ),
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
                                  content: TextFormField(
                                    decoration: const InputDecoration(hintText: "Password"),
                                    controller: passwordController,
                                  ), 
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () async {

                                        var newPassword = passwordController.text;
                                        user.updatePassword(newPassword);

                                        setState(() {});
                                        Navigator.pop(context);
                                      },
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
                  )
                ]
              )
            )
          ]
        )
    );
  }
}
