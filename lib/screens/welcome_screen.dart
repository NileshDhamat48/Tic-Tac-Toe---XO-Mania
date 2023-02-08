import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/widgets/showcasewidget.dart';
import 'package:tictactoexomania/screens/pickup_screen.dart';
import 'package:tictactoexomania/widgets/reusable_button.dart';
import 'package:tictactoexomania/widgets/wp_screen_text_widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final keyOne = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context)!.startShowCase([keyOne]),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGameScreenBackgroundColor1,
      appBar: AppBar(
        backgroundColor: kGameScreenBackgroundColor2,
        // leading:
        centerTitle: true,
        title: Text(
          "Tic Tac Toe",
          style: GoogleFonts.lato(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),

        actions: [
          showCaseWidget(keyOne: keyOne),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) => Text(
                      "O",
                      style: TextStyle(
                          color: kLetterOColor,
                          fontSize: constraints.maxHeight / 3.1,
                          fontFamily: 'Carter'),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) => Text(
                      "X",
                      style: TextStyle(
                          color: kLetterXColor,
                          fontSize: constraints.maxHeight / 3.1,
                          fontFamily: 'Carter'),
                    ),
                  ),
                ],
              ),
            ),
            ReusableButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickUpScreen()),
                );
              },
              text: "Choose Your Side",
            )
          ],
        ),
      ),
    );
  }
}
