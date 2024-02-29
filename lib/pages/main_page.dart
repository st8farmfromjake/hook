import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:hook/palette.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      'Hook',
                      textAlign: TextAlign.center,
                      style: kHeading,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                  child: Center(
                    child: Text(
                      '<o))))><',
                      textAlign: TextAlign.center,
                      style: kBodyFish,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 160,
                      margin: const EdgeInsets.only(top:50,right:20,left:200),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5)
                      ),
                      child   : const Text(
                        'Email\nSender',
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      )
                    ),
                    Container(
                      height: 150,
                      width: 160,
                      margin: const EdgeInsets.only(top:50,right:100, left:10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child   : const Text(
                        'Analytics\nBoard',
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      )
                    ),
                    Container(
                      width: 130,
                      height: 40,
                      margin: const EdgeInsets.only(top:145,right:100, left:25),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16)),
                      child   : const Text(
                        'Go There',
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      )
                    ),
                    Container(
                      width: 130,
                      height: 40,
                      margin: const EdgeInsets.only(top:145,right:30, left:215),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16)),
                      child   : const Text(
                        'Go There',
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      )
                    )
                  ]
                ),
                Row(
                  children: [
                    Container(
                      height: 250,
                      width: 350,
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child   : const Text(
                        'Mission Statement\n\nTo increase phishing email scam awareness within companies',
                        style: kSubHeading,
                        textAlign: TextAlign.center,
                      )
                    ),
                  ]
                )
              ]
            ) 
          ),
        ),

      ]
    );
  }
}