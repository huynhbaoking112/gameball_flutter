import 'package:flutter/material.dart';



class MyPlayer extends StatelessWidget {

  final double playerX;
  final double playerWidth;

  const MyPlayer({super.key, required this.playerX, required this.playerWidth});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment((playerWidth + 2*playerX)/(2-playerWidth), 0.9),
      child: Container(
        height: 10,
        width: MediaQuery.of(context).size.width * playerWidth /2,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
