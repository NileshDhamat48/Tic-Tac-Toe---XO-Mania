import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';


class NameTextFieldWidget extends StatelessWidget {

  final setP1, setP2;
  NameTextFieldWidget({this.setP1,this.setP2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Your Name",style:GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.w600),),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Container(
              child: TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: kTextFieldDecoration.copyWith(hintText: setP1 ? 'Name' : 'Name'),
                onChanged: (value){
                  setP1 ? UI.player1Name = value : UI.player2Name = value;
                },
              ),
              height: 40.0,
              width: 115.0,
            ),
          ),
        ],
      ),
    );
  }
}
