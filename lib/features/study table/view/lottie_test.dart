import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestLottie extends StatelessWidget {
  static const String routeName = '/Lottie';
  const TestLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Lottie.asset('assets/lottie/black fire.json',
                  height: 50, width: 50),
              const    SizedBox(height: 20,),
                     Lottie.asset('assets/lottie/red fire.json',
                  height: 50, width: 50),
            ],
          ),
            Row(
            children: [
              Lottie.asset('assets/lottie/study2.json',
                  height: 50, width: 50),
               const   SizedBox(height: 20,),
                     Lottie.asset('assets/lottie/study.json',
                  height: 50, width: 50),
            ],
          ),
            Row(
            children: [
              Lottie.asset('assets/lottie/lottieflow-background-07-000000-easey.json',
                  height: 50, width: 50),
               const   SizedBox(height: 20,),
                     Lottie.asset('assets/lottie/lottieflow-cta-01-2-000000-easey.json',
                  height: 50, width: 50),
            ],
          ),
        
        ],
      ),
    );
  }
}
