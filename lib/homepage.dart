import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:learnpackages/brick.dart';
import 'package:learnpackages/converscreen.dart';
import 'package:learnpackages/gameover.dart';
import 'package:learnpackages/myball.dart';
import 'package:learnpackages/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //Start game variable
  bool hasGameStarted = false;

  // position ball
  double ballX = 0;
  double ballY = 0;

  //player variables
  double playerWidth = 0.4;
  double playerX = -0.2;

  //current Direction
  direction vertical = direction.DOWN;
  direction horizontal = direction.LEFT;

  //is gameover
  bool gameOver = false;

  //brick variables
  static double brickX = -1 + wallGap;
  static double brickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  bool brickBroken = false;
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  List MyBricks = [
//[x, y, broken = true/false]
    [brickX + 0 * (brickWidth + brickGap), brickY, false],
    [brickX + 1 * (brickWidth + brickGap), brickY, false],
    [brickX + 2 * (brickWidth + brickGap), brickY, false],
  ];

  //start game
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 30), (timer) {
      updateDirection();
      if (gameOver) {
        timer.cancel();
      }
      move();

      //check brick broken
      checkBrickBroken();
    });
  }

  //check if brick is hit
  void checkBrickBroken() {
    for (int i = 0; i < MyBricks.length; i++) {
      if (ballX >= MyBricks[i][0] &&
          ballX <= MyBricks[i][0] + brickWidth &&
          ballY <= brickHeight + MyBricks[i][1] &&
          ballY >= brickY &&
          MyBricks[i][2] == false) {
        setState(() {
          MyBricks[i][2] = true;
          horizontal =
              horizontal == direction.LEFT ? direction.RIGHT : direction.RIGHT;
          vertical = vertical == direction.UP ? direction.DOWN : direction.UP;
        });
      }
      ;
    }
  }

  void updateDirection() {
    if (ballY >= 0.9 && ballX == (playerWidth / 2 + playerX)) {
      vertical = direction.UP;
    } else if (ballY >= 0.9 &&
        ballX >= playerX &&
        ballX < (playerWidth / 2 + playerX)) {
      vertical = direction.UP;
      horizontal = direction.LEFT;
    } else if (ballY >= 0.9 &&
        ballX <= playerX + playerWidth &&
        ballX > (playerWidth / 2 + playerX)) {
      vertical = direction.UP;
      horizontal = direction.RIGHT;
    } else if (ballY > 0.9) {
      setState(() {
        gameOver = true;
      });
    }

    //wall top
    if (ballY <= -1) {
      vertical = direction.DOWN;
    }

    //wall right
    if (ballX >= 1) {
      horizontal = direction.LEFT;
    }

    //wall left
    if (ballX <= -1) {
      horizontal = direction.RIGHT;
    }
  }

  void move() {
    if (horizontal == direction.LEFT && vertical == direction.UP) {
      setState(() {
        ballX -= 0.01;
        ballY -= 0.01;
      });
    } else if (horizontal == direction.LEFT && vertical == direction.DOWN) {
      setState(() {
        ballX -= 0.01;
        ballY += 0.01;
      });
    } else if (horizontal == direction.RIGHT && vertical == direction.DOWN) {
      setState(() {
        ballX += 0.01;
        ballY += 0.01;
      });
    } else if (horizontal == direction.RIGHT && vertical == direction.UP) {
      setState(() {
        ballX += 0.01;
        ballY -= 0.01;
      });
    }
  }

  //move left
  void moveLeft() {
    setState(() {
      playerX - 0.2 >= -1 ? playerX -= 0.2 : null;
    });
  }

  //move right
  void moveRight() {
    setState(() {
      playerX + playerWidth + 0.2 <= 1 ? playerX += 0.2 : null;
    });
  }

  void resetGame(){
    print("kingne");
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      gameOver = false;
      hasGameStarted = false;
        List MyBricks = [
//[x, y, broken = true/false]
    [brickX + 0 * (brickWidth + brickGap), brickY, false],
    [brickX + 1 * (brickWidth + brickGap), brickY, false],
    [brickX + 2 * (brickWidth + brickGap), brickY, false],
  ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
            backgroundColor: Colors.amber[100],
            body: Center(
              child: Stack(
                children: [
                  //Tap to play
                  CoverScreen(hasGameStarted: hasGameStarted),

                  //game over
                  GameOver(isOver: gameOver,onPress:(){
                    resetGame();
                  }),

                  // ball
                  MyBall(ballY: ballY, ballX: ballX),

                  //player
                  MyPlayer(
                    playerX: playerX,
                    playerWidth: playerWidth,
                  ),

                  //the brick
                  MyBrick(
                      brickHeight: brickHeight,
                      brickWidth: brickWidth,
                      brickX: MyBricks[0][0],
                      brickY: MyBricks[0][1],
                      brickBroken: MyBricks[0][2]),
                  MyBrick(
                      brickHeight: brickHeight,
                      brickWidth: brickWidth,
                      brickX: MyBricks[1][0],
                      brickY: MyBricks[1][1],
                      brickBroken: MyBricks[1][2]),
                  MyBrick(
                      brickHeight: brickHeight,
                      brickWidth: brickWidth,
                      brickX: MyBricks[2][0],
                      brickY: MyBricks[2][1],
                      brickBroken: MyBricks[2][2])
                ],
              ),
            )),
      ),
    );
  }
}
