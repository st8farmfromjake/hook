import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hook/components/my_textfield.dart';
import 'package:hook/palette.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool showError = false;

  void signUserIn() async {
  // Show the loading dialog
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents the dialog from being dismissed accidentally
    builder: (context) => const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)),
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // Check if the widget is still mounted before popping the dialog
    // if (mounted) {
    //   Navigator.pop(context); // Dismiss the loading dialog
    // }
  } on FirebaseAuthException catch (e) {
    // Check if the widget is still mounted before popping the dialog and showing the error message
    if (mounted) {
      Navigator.pop(context); // Dismiss the loading dialog
      showErrorMessage(e.code); // Show the error message
    }
  }
}


  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.orange,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
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
                  Container(
                    height: 150,
                    child: const Center(
                      child: Text(
                        'Hook',
                        style: kHeading,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
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
                                "Login!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            //username textfeild
                            MyTextField(
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                              isError: showError && emailController.text.isEmpty,
                            ),
                  
                            const SizedBox(height: 10),
                  
                            //password text feild
                            MyTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                              isError: showError && passwordController.text.isEmpty,
                            ),
                  
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 100),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(16)),
                              child: TextButton(
                                  onPressed: signUserIn,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20.0),
                                    child: Text(
                                      'Sign In',
                                      style: kBodyText,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
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
