import 'package:flutter/material.dart';



class MyBall extends StatelessWidget {

  final double ballX;
  final double ballY;

  const MyBall({super.key, required this.ballY, required this.ballX});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment(ballX,ballY),
      child: Container(
        height: 15,
        width:15 ,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
