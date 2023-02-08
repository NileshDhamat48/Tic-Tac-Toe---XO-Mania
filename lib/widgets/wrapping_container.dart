import 'package:flutter/material.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';

class WrappingContainer extends StatelessWidget{

  final onTap,containerNo; String letter = "";
  WrappingContainer({this.onTap,required this.letter, this.containerNo});

  @override
  Widget build(BuildContext context) {

    UI.containerWidth = MediaQuery.of(context).size.width - 60;

    UI.bw = UI.containerWidth / 3;

    UI.wpWidth = UI.bw - 16;
    UI.wpHeight = UI.bw - 16;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: UI.finalResult != "Win" ? BoxDecoration(
              color: kGameScreenBackgroundColor1,
              borderRadius: BorderRadius.circular(10.0),
            ) : BoxDecoration(
              color: UI.colorMap[containerNo] == kG ? Colors.lightGreen : kGameScreenBackgroundColor1,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              UI.chars[containerNo] == "" ? letter : UI.chars[containerNo],
              style: UI.finalResult != "Win" ? TextStyle(
                fontFamily: UI.chars[containerNo] == "X" ? 'Carter' : "Paytone",
                fontSize: UI.wpHeight / 1.6,
                color: UI.chars[containerNo] == "X" ? kLetterXColor : kLetterOColor,
              ) : TextStyle(
                fontFamily: UI.chars[containerNo] == "X" ? 'Carter' : "Paytone",
                fontSize: UI.wpHeight / 1.6,
                color: UI.colorMap[containerNo] == kG ? Colors.white :
                UI.chars[containerNo] == "X" ? kLetterXColor : kLetterOColor
              ),
              textAlign : TextAlign.center,
            ),
            height: UI.wpHeight,
            width: UI.wpWidth,
          ),
        ),
    );
  }
}