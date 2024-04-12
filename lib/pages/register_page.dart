import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hook/components/my_textfield.dart';
import 'package:hook/palette.dart';
import '../widgets/widgets.dart';
import 'package:hook/api_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Email & Password controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final usernameController = TextEditingController();

  bool isChecked = false;

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.redAccent,
            title: Center(
              child: Text(
                textAlign: TextAlign.center,
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  //Sign in method
  void signUserUp() async {
    if (isChecked) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseAuth.instance.currentUser!.updateDisplayName(usernameController.text);
        try {
          final result = await ApiService().createNewLink();
          print('Path: ${result['path']}');
          print('Id: ${result['linkId']}');
        } catch (e) {
          print('Error creating link: $e');
        }
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        print(e.code);
        Navigator.pop(context);
      }
    } else {
      showErrorMessage(
          "You must accept Hook's terms and conditions before creating an account");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        const BackgroundImage(),
        Scaffold(
          resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  height: 100,
                  child: const Center(
                    child: Text(
                      'Hook',
                      style: kHeading,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
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
                              "Register your Account!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),
                          MyTextField(
                            controller: usernameController,
                            hintText: 'Your Name',
                            obscureText: false,
                          ),

                          const SizedBox(height: 10),

                          //username textfeild
                          MyTextField(
                            controller: emailController,
                            hintText: 'Email',
                            obscureText: false,
                          ),

                          const SizedBox(height: 10),

                          //password text feild
                          MyTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: true,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Accept Hook terms and conditions",
                            style: TextStyle(color: Colors.grey[200]),
                          ),
                          Checkbox(
                            value: isChecked,
                            checkColor: Colors.white,
                            activeColor: Colors.orange,
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1.5,
                            ),
                            onChanged: (newBool) {
                              setState(() {
                                isChecked = newBool!;
                              });
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(16)),
                            child: TextButton(
                                onPressed: signUserUp,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Text(
                                    'Create your Account',
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
                            'Already a member?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Log in Now',
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
