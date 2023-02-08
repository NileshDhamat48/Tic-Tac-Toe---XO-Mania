import 'package:flutter/material.dart';
import 'package:tictactoexomania/constants.dart';
import 'profile_container_widget.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';

class EntireRowInGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "D",
              style: kScoreTextStyle,
            ),
            Text(
              "  :  ",
              style: kScoreTextStyle,
            ),
            Text(
              UI.draws.toString(),
              style: kScoreTextStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileContainer(
                profileName: UI.player1Name,
                letter: UI.side == "X" ? "X" : "O",
                imageName: UI.player1ImageName),
            SizedBox(
              width: 30,
            ),
            ProfileContainer(
                profileName: UI.player2Name,
                letter: UI.side == "X" ? "O" : "X",
                imageName: UI.player2ImageName),
          ],
        )
      ],
    );
  }
}
