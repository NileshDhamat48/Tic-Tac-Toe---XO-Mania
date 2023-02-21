import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tictactoexomania/screens/welcome_screen.dart';
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
  BannerAd? _ad;

  @override
  void initState() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
    ui.colorsAndSide();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _ad?.dispose();
    super.dispose();
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
            SizedBox(height: 10,),

            Expanded(
              child: Column(children: [
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
                SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            if (_ad != null)
              Container(
                width: _ad!.size.width.toDouble(),
                height: _ad!.size.height.toDouble(),
                alignment: Alignment.center,
                child: AdWidget(ad: _ad!),
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