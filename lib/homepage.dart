import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:learnpackages/converscreen.dart';
import 'package:learnpackages/myball.dart';
import 'package:learnpackages/player.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  //Start game variable
  bool hasGameStarted = false;

  // position ball
  double ballX = 0;
  double ballY = 0;

  //player variables
  double playerWidth = 0.3;
  double playerX = 0;


  //start game
  void startGame(){
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        ballY += 0.01;
      });
    });
  }

  //move left
  void moveLeft(){
    setState(() {
     playerX - 0.2 >= -1 ? playerX-=0.2 : null;
    });
  }
  //move right
  void moveRight(){
    setState(() {
      playerX + 0.2 <= 1 ? playerX+=0.2 : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();
        }else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
            backgroundColor: Colors.deepPurple[100],
            body: Center(
              child: Stack(
                children: [
                  //Tap to play
                  CoverScreen(hasGameStarted: hasGameStarted),
      
                  // ball
                  MyBall(ballY: ballY, ballX: ballX),
      
                  //player
                  MyPlayer(playerX: playerX, playerWidth: playerWidth,),


                  // where is playerX exactly
                  Align(
                    alignment: Alignment(playerX, 0.9),
                    child: Container(
                      color: Colors.red,
                      width: 4,
                      height: 15,
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
