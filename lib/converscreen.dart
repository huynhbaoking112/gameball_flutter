import 'package:flutter/material.dart';



class CoverScreen extends StatelessWidget {

  final bool hasGameStarted;


  const CoverScreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted? Container() :Align(
      alignment: Alignment(0,-0.1),
      child:  Container(
        child: Text('Tap to Play', style: TextStyle(color: Colors.deepPurple[400], fontSize: 17, fontWeight: FontWeight.w700),),
      ),
    );
  }
}
