import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBackgroundColor = Color(0xFFFF4B4B);
const kTextColor = Color(0xFFFFCA26);
const kGameScreenBackgroundColor = Color(0XFF36248D);
const kGameScreenBackgroundColor1 = Color(0XFF5eb1ab);
const kGameScreenBackgroundColor2 = Color(0XFF0a6b63);
const kGameScreenContainerColor = Color(0XFF6649C4);
const kLetterXColor = Color(0XFFEB1751);
const kLetterOColor = Color(0XFFFFD032);
const kSettingsBoxColor = Color(0xFF9b70e5);
const kProfileContainerColor = Color(0XFF27175D);
const kActiveCardColor = Color(0xFF9b70e5);
const kYourTurnText = TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);
 TextStyle kResultText = GoogleFonts.lato(color: Colors.white,/*fontFamily: 'Carter'*/fontWeight: FontWeight.bold,);
const kScoreTextStyle = TextStyle(fontSize: 28.0,color: Colors.white, fontFamily: 'Paytone');
const kSpace = Divider(height: 10.0,);
const kReusableButton = "";
const kMaxSeconds = 15;
const kG = "";
const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
  fillColor: kGameScreenBackgroundColor2,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0),),
    borderSide: BorderSide.none,
  ),
  hintStyle: TextStyle(color: Colors.white),
);
const kSettingsBoxLetterStyle = TextStyle(color:Colors.black, fontFamily: 'Carter',);
const kDivider = Divider(height: 6.0, color: Colors.white, thickness: 0.5,);
const kDivider1 = Divider(height: 6.0, color: Colors.black, thickness: 0.5,);