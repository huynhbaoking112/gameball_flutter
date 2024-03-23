import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;

  const MyBrick({
    super.key,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment((2*brickX + brickWidth)/(2-brickWidth), brickY),
      child: brickBroken ?Container() : Container(
        width: MediaQuery.of(context).size.width / 2 * brickWidth,
        height: MediaQuery.of(context).size.height / 2 * brickHeight,
        decoration: BoxDecoration(
            color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
