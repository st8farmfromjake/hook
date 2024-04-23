import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hook/api_service.dart';
import 'package:hook/components/my_textfield.dart';
import 'package:hook/palette.dart';
import '../widgets/widgets.dart';
import '../test_emails.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController senderNameController = TextEditingController();
  late final List<TextEditingController> controllers;
  late final String path;

  bool showError = false;

  _EmailPageState() {
    // Initialize the list in the constructor body
    controllers = [
      emailController,
      nameController,
      companyNameController,
      senderNameController,
    ];
  }

  @override
  void initState() {
    super.initState();
    fetchPath();
  }

  void fetchPath() async {
    final db = FirebaseFirestore.instance;
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final docRef = db.collection("user_email_info").doc(userEmail);
    try {
      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        path = data['path']; // Now path is initialized and ready to use.
      });
    } catch (e) {
      print("Error getting document: $e");
    }
  }


  @override
  void dispose() {
    // Dispose of the controllers when the State is disposed
    emailController.dispose();
    nameController.dispose();
    companyNameController.dispose();
    senderNameController.dispose();
    super.dispose();
  }

  void showMessage(String message, bool error) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              backgroundColor: error
                  ? const Color.fromARGB(255, 255, 0, 0)
                  : Color.fromARGB(255, 0, 190, 0),
              title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }

  void updateTotalEmailsSent() async {
    final db = FirebaseFirestore.instance;
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    debugPrint("The users email is $userEmail");
    //getting document (will be used to get the previous total email sent feild)
    final docRef = db.collection("user_email_info").doc(userEmail);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    //increments totalEmailsSent
    await db
        .collection('user_email_info')
        .doc(userEmail)
        .update({"totalEmailsSent": FieldValue.increment(1)});

    //userEmail Could be null
    // final userRef = db.collection("user_email_info").doc(userEmail);
    // userRef.update({"totalEmailsSent": true}).then(
    //     (value) => print("DocumentSnapshot successfully updated!"),
    //     onError: (e) => print("Error updating document $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 75,
                    child: const Center(
                      child: Text(
                        'Hook',
                        style: kHeading,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Center(
                              child: Text(
                                "Configure Email!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            const Center(
                              child: Text(
                                "Please fill in all of the fields below and hit 'Send Email' to HOOK your your employee!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),
                            //email textfeild
                            MyTextField(
                              controller: emailController,
                              hintText: 'Email(s) - csv',
                              isError:
                                  showError && emailController.text.isEmpty,
                            ),

                            const SizedBox(height: 10),

                            //name text feild
                            MyTextField(
                              controller: nameController,
                              hintText: 'Recipient Name(s) - csv',
                              isError: showError && nameController.text.isEmpty,
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //company name text feild
                            MyTextField(
                              controller: companyNameController,
                              hintText: 'Company Name',
                              isError: showError &&
                                  companyNameController.text.isEmpty,
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            //sender name text feild
                            MyTextField(
                              controller: senderNameController,
                              hintText: 'Sender Name',
                              isError: showError &&
                                  senderNameController.text.isEmpty,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(16)),
                              child: TextButton(
                                  onPressed: () {
                                    if (path == null || path.isEmpty) {
                                      showMessage('Path is not yet initialized. Please wait.', true);
                                      return;
                                    }
                                    
                                    if (emailController.text.isEmpty || nameController.text.isEmpty || companyNameController.text.isEmpty || senderNameController.text.isEmpty) {
                                      // Show error message
                                      showMessage('Please fill in all the fields.', true);
                                      return;
                                    }
                                    
                                    setState(() {
                                      showError = false; // Optionally reset error state on successful submission
                                    });
                                    
                                    debugPrint('Button pressed!');
                                    List<String> emailsList = emailController.text.split(',');
                                    List<String> namesList = nameController.text.split(',');
                                    
                                    for (int i = 0; i < emailsList.length; i++) {
                                      sendEmail(
                                        emailAdd: emailsList[i],
                                        name: namesList[i],
                                        fromName: senderNameController.text,
                                        companyName: companyNameController.text,
                                        link: 'https://link.wolltechnologies.com/$path'
                                      );
                                      showMessage('Email Sent To\n${emailController.text}', false);
                                      updateTotalEmailsSent();
                                    }
                                    
                                    controllers.forEach((controller) => controller.clear());
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    child: Text(
                                      'Send Email',
                                      style: kBodyText,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))),
      ],
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  });
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: hint,
            prefixIcon:
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.hint,
    required this.inputAction,
  });
  final String hint;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: hint,
            prefixIcon:
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
            hintStyle: kBodyText,
          ),
          obscureText: true,
          style: kBodyText,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
