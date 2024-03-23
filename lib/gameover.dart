import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatelessWidget {
  final bool isOver;

  final Function onPress;

  const GameOver({super.key, required this.isOver, required this.onPress});

  static var gameFont = GoogleFonts.pressStart2p(textStyle:TextStyle(
    color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 28
  ));

  @override
  Widget build(BuildContext context) {
    return isOver
        ? Stack(
            children: [
              Center(
                child: Container(
                  child:  Text(
                    "G A M E O V E R",
                    style: gameFont
                  ),
                ),
              ),
              Align(
                  alignment: Alignment(0, 0.3),
                  child: ElevatedButton(
                    
                    child: Text("Play Again"), 
                    onPressed: (){
                      onPress();
                    },
                  ))
            ],
          )
        : Container();
  }
}
