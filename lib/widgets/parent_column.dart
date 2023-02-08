import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/widgets/name_text_field_widget.dart';
import 'package:tictactoexomania/widgets/row_contains_avatar_and_images1.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';
import 'package:tictactoexomania/widgets/row_contains_avatar_and_images2.dart';

class COLUMNWIDGET extends StatefulWidget {

  @override
  _COLUMNWIDGETState createState() => _COLUMNWIDGETState();
}

class _COLUMNWIDGETState extends State<COLUMNWIDGET> {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("Profile", style: GoogleFonts.lato(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.w900)),
          ),
          kDivider1,
          Row(
            children: [
              Text('Player 1',style: GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.w900),),
            ],
          ),
          NameTextFieldWidget(setP1: true, setP2: false,),
          RowAvatarImages1(),
          kDivider1,
          Row(
            children: [
              Text('Player 2',style: GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.w900),),
            ],
          ),
          NameTextFieldWidget(setP1: false, setP2: true,),
          RowAvatarImages2(),
          kDivider1,
          Column(
            children: [

              Row(
                children: [
                  Text('Draw Score', style: kYourTurnText,),
                  SizedBox(width: 10.0,),
                  Container(
                    child: Row(
                      children: [
                        buildIconButton(false, true, Icons.arrow_upward),
                        Text(UI.noOfDraws.toString(), style: kYourTurnText,),
                        buildIconButton(false, true, Icons.arrow_downward),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        UI.muteSound = !UI.muteSound;
                      });
                    },
                    icon: Icon(
                      UI.muteSound ?  Icons.volume_off : Icons.volume_up,
                      color: kGameScreenBackgroundColor2,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Win Score", style: kYourTurnText,),
                  SizedBox(width: 18.0,),
                  Container(
                    child: Row(
                      children: [
                        buildIconButton(true,false,Icons.arrow_upward),
                        Text(UI.noOfWins.toString(), style: kYourTurnText,),
                        buildIconButton(true, false, Icons.arrow_downward),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  IconButton buildIconButton(bool wins, bool draws ,IconData iconSymbol) {

    return IconButton(
      onPressed: (){
        if(wins == true && draws == false){
          if(iconSymbol == Icons.arrow_upward){
            if(UI.noOfWins < UI.maxWins){
              setState(() {
                UI.noOfWins++;
              });
            }
          }
          else if(iconSymbol == Icons.arrow_downward){
            if(UI.noOfWins > UI.minWins){
              setState(() {
                UI.noOfWins--;
              });
            }
          }
        }
        else if(wins == false && draws == true){
          if(iconSymbol == Icons.arrow_upward){
            if(UI.noOfDraws < UI.maxWins) {
              setState(() {
                UI.noOfDraws++;
              });
            }
          }
          else if(iconSymbol == Icons.arrow_downward){
            if(UI.noOfDraws > UI.minWins) {
              setState(() {
                UI.noOfDraws--;
              });
            }
          }
        }
      },
      icon: CircleAvatar(
        backgroundColor: wins == true && draws == false ?

            iconSymbol == Icons.arrow_upward ?
                UI.noOfWins < UI.maxWins ? kGameScreenBackgroundColor2 : Colors.blueGrey[400]
            : UI.noOfWins > UI.minWins ? kGameScreenBackgroundColor2 : Colors.blueGrey[400]

        :
            iconSymbol == Icons.arrow_upward ?
                UI.noOfDraws < UI.maxWins ? kGameScreenBackgroundColor2 : Colors.blueGrey[400] :
                UI.noOfDraws > UI.minWins ? kGameScreenBackgroundColor2 : Colors.blueGrey[400],

        child: Icon(
          iconSymbol,
          color: Colors.white,
        ),
      ),
    );
  }
}