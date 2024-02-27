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
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 160,
                      margin: const EdgeInsets.only(top:50,right:30,left:30),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5)
                      )
                    ),
                    Container(
                      height: 150,
                      width: 160,
                      margin: const EdgeInsets.only(top:50,right:20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                      )
                    ),
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
                      
                    ),
                  ]
                )
              ]
            ) 
          ),
          )
      ]
    );
  }
}