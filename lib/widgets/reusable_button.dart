import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoexomania/constants.dart';

class ReusableButton extends StatelessWidget {

  final onTap,text;
  ReusableButton({this.onTap,this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: MaterialButton(
        height: 40,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        textColor: Colors.white,
        color: kGameScreenBackgroundColor2,
        minWidth : double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          text,
          style: GoogleFonts.lato(/*fontFamily: 'Paytone'*/ fontSize : 22.0, fontWeight: FontWeight.w900),
        ),
        onPressed: onTap,
      ),
    );
  }
}