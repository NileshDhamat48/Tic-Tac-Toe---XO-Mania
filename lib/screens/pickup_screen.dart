import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoexomania/widgets/container_widget.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/widgets/reusable_button.dart';
import 'package:tictactoexomania/screens/game_screen.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';

class PickUpScreen extends StatefulWidget {

  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {

  @override
  void initState() {
    ui.colorsAndSide();
    super.initState();
  }

  void updateColor(letter selectedLetter) =>  ui.updateColor(selectedLetter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGameScreenBackgroundColor1,
      appBar: AppBar(
        backgroundColor: kGameScreenBackgroundColor2,
        // leading:
        centerTitle: true,
        title: Text(
          "Choose a side",
          style: GoogleFonts.lato(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),


      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 300,
                  child: Expanded(
                    child: Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              updateColor(letter.cardX);
                              UI.side = "X";
                            });
                          },
                          child: ContainerWidget(
                            color: UI.xCardColor, text: "X",
                            textColor: UI.xTextColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              updateColor(letter.cardO);
                              UI.side = "O";
                            });
                          },
                          child: ContainerWidget(
                            color: UI.oCardColor, text: "O",
                            textColor: UI.oTextColor,
                          ),
                        ),
                      ),
                    ],),
                  ),
                ),
              ),
            ),
            // Button Code
            ReusableButton(
              onTap: (){
                ui.remainingVars();
                ui.setWinningVariables();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => GameScreen(chosenLetter: UI.side,),
                ));
              },
              text: 'Start',
            )
          ],
        ),
      ),
    );
  }
}