
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tictactoexomania/Models/TicTacToeLogic.dart';
import 'package:tictactoexomania/screens/result_screen.dart';
import 'package:tictactoexomania/widgets/profileContainerRow.dart';
import 'package:tictactoexomania/widgets/wrapping_container.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';
class Constant {
  static const String BANNER_ADS = "ca-app-pub-5270778529330824/7746851862";
  // static const String BANNER_ADS = "ca-app-pub-3940256099942544/3419835294"; //test
  static const String APP_OPEN_ADS = "ca-app-pub-5270778529330824/4838188316";
  // static const String APP_OPEN_ADS = "ca-app-pub-3940256099942544/3419835294";
  static const String INTERSTITIAL_ADS = "ca-app-pub-3940256099942544/1033173712";
  static const String REWARDEAD_ADS = "ca-app-pub-5270778529330824/5194142428";
  static const String REWARDED_INTERSTITAL_ADS = "ca-app-pub-3940256099942544/5354046379";

}
UI ui = UI();
TicTacToe game = TicTacToe();


class GameScreen extends StatefulWidget{

  String chosenLetter;
  GameScreen({required this.chosenLetter});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int maxFailedLoadAttempts = 6;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? Constant.REWARDEAD_ADS
            : 'ca-app-pub-3940256099942544/1712485313',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd?.setImmersiveMode(true);
    _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? Constant.REWARDED_INTERSTITAL_ADS
            : 'ca-app-pub-3940256099942544/6978759866',
        request: AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd?.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
              print('$ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
            print('$ad onAdDismissedFullScreenContent.');
            ad.dispose();
            _createRewardedInterstitialAd();
          },
          onAdFailedToShowFullScreenContent:
              (RewardedInterstitialAd ad, AdError error) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
            ad?.dispose();
            _createRewardedInterstitialAd();
          },
        );

    _rewardedInterstitialAd?.setImmersiveMode(true);
    _rewardedInterstitialAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        });
    _rewardedInterstitialAd = null;
  }
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? Constant.INTERSTITIAL_ADS
            : 'ca-app-pub-3940256099942544/4411468910',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd?.show();
    _interstitialAd = null;
  }

  @override
  void initState() {
    _createInterstitialAd();
    _createRewardedInterstitialAd();
    _createRewardedAd();
    widget.chosenLetter == "O"? ui.startLetter("O") : ui.startLetter("X");
    ui.initializeColorMap();
    startTimer();
    super.initState();
  }

  static const maxSeconds = 15;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if(seconds > 0){
        setState(() => seconds--);
      }else{
        setState(() {
          UI.letterO = !UI.letterO;
          UI.letterX = !UI.letterX;
        });
        stopTimer();
      }
    });
  }

  void resetTimer() => setState(() => seconds = maxSeconds);

  void stopTimer({bool reset = true, bool start = true}){
    if(reset){
      resetTimer();
    }
    timer?.cancel();
    if(start) startTimer();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    _rewardedInterstitialAd?.dispose();
    _rewardedAd?.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void checkRows() {setState(() {if(ui.checkR1()) ui.setRow1(); if(ui.checkR2()) ui.setRow2(); if(ui.checkR3()) ui.setRow3();});}
    void checkColumns() {setState(() {if(ui.checkC1()) ui.setCol1(); if(ui.checkC2()) ui.setCol2(); if(ui.checkC3()) ui.setCol3();});}
    void checkLeftDiagnol()  {setState(() {if(ui.checkLeftDiagnol()) ui.setLeftDiagnol();});}
    void checkRightDiagnol() {setState(() {if(ui.checkRightDiagnol()) ui.setRightDiagnol();});}


    void navigateToResultScreen(){
      Future.delayed(
          Duration(seconds: 3),(){
        _showRewardedAd();
        });
      Future.delayed(
          Duration(milliseconds: 100),(){
        // _showInterstitialAd();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WinningScreen(
                  winningLetter: UI.ansLetter,
                  onTap: (){
                    ui.setAllVars();
                    stopTimer();
                    Navigator.pop(context);
                  },
                ),
          ),
        ).then((value) => setState(() {})); // Force reload the page
      }
      );
    }

    void changeWinningLetterColors(String ansLetter) {

      /*Getting the winning directions that means
      * in what direction the game has won  and checking that
      * relevant direction to change the container colors to Green*/

      UI.winningDirection == "checkRows" ? checkRows() : UI.winningDirection ==
          "checkColumns" ? checkColumns()
          : UI.winningDirection == "checkLeftDiagnol"
          ? checkLeftDiagnol()  : checkRightDiagnol();

      /*If X wins the game then the following if condition executes*/
      if(ansLetter == "X"){
        UI.xWins++;
        if(UI.xWins == UI.noOfWins){
          // stop the timer and navigate to final screen
          stopTimer(start: false);
          navigateToResultScreen();
        }
        else{
          // Next game will be started with O after one second
          Future.delayed(Duration(milliseconds: 1000), (){
            ui.setRemainingVarsColorMap();
          });
          setState(() => UI.letterO = true);
          stopTimer();
        }
      }

      else if(ansLetter == "O"){
        UI.oWins++;
        if(UI.oWins == UI.noOfWins){
          stopTimer(start: false);
          navigateToResultScreen();
        }
        else{
          Future.delayed(Duration(milliseconds: 1000),(){
          ui.setRemainingVarsColorMap();
          });
          setState(() => UI.letterX = true);
          stopTimer();
        }
      }
    }

    void fun(int r,int c, int containerNo){

      // This if statement is add to avoid unnecessary taps when the game draws or wins
      if(UI.finalResult == "") {

        UI.isSelected[containerNo] = true;

        //Letter X will be shown on the screen and next turn will be given to letterO
        if (UI.letterX && UI.mat[r][c] == "") ui.letterXTurn();

        //Letter O will be shown on the screen and next turn will be given to letterX
        else if (UI.letterO && UI.mat[r][c] == "") ui.letterOTurn();

        /*
        The current letter will only be painted on the container provided that
        the container is empty.
        */
        if(UI.chars[containerNo] == ""){
          setState(() {
            UI.chars[containerNo] = UI.character;
            /*Timer will be stopped for the current player and it
            * will be reset to 15 seconds for the next player*/
            stopTimer();
          });
        }

        // Matrix will be updated and checks whether game has drawn or won or none
        ui.updateMatrix(r, c, UI.character);

        // Now checking Winning Condition
        if (game.checkWinningCondition() == "Win") {
          UI.finalResult = "Win";
          if(UI.muteSound == false) {
            ui.playWinningSound();
          }
          // Changing the background of winning letter containers to Green.
          changeWinningLetterColors(UI.ansLetter);
        }

        else if (game.checkDrawCondition() == "Draw") {
          UI.draws++;
          if(UI.muteSound == false) {
            ui.playDrawSound();
          }
          UI.finalResult = "Draw";
          if(UI.draws == UI.noOfDraws){
            stopTimer();
            navigateToResultScreen();
          }
          else{
            Future.delayed(Duration(milliseconds: 1000),(){
              UI.ansLetter == "X" ?  setState(() => UI.letterO = true) : setState(() => UI.letterX = true);
              ui.setRemainingVarsColorMap();
              stopTimer();
            });
          }
        }
        if(UI.muteSound == false) ui.playLetterSound();
      }
    }

    UI.deviceW = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: kGameScreenBackgroundColor1,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 40.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: seconds/maxSeconds,
                        valueColor: AlwaysStoppedAnimation(kProfileContainerColor),
                        backgroundColor: Colors.white,
                      ),
                      Text(
                        '$seconds',
                        style: kYourTurnText.copyWith(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            EntireRowInGameScreen(),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
              child: Container(
                width: UI.deviceW - 50,
                height: UI.deviceW - 50,
                decoration: BoxDecoration(
                  color: kGameScreenBackgroundColor2,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      WrappingContainer(onTap: (){fun(0,0,0);}, letter: UI.isSelected[0] ?  UI.character: "",containerNo: 0,),
                      WrappingContainer(onTap: (){fun(1,0,1);}, letter: UI.isSelected[1] ?  UI.character: "",containerNo: 1,),
                      WrappingContainer(onTap: (){fun(2,0,2);}, letter: UI.isSelected[2] ?  UI.character: "",containerNo: 2,),
                      WrappingContainer(onTap: (){fun(0,1,3);}, letter: UI.isSelected[3] ?  UI.character: "",containerNo: 3,),
                      WrappingContainer(onTap: (){fun(1,1,4);}, letter: UI.isSelected[4] ?  UI.character: "",containerNo: 4,),
                      WrappingContainer(onTap: (){fun(2,1,5);}, letter: UI.isSelected[5] ?  UI.character: "",containerNo: 5,),
                      WrappingContainer(onTap: (){fun(0,2,6);}, letter: UI.isSelected[6] ?  UI.character: "",containerNo: 6,),
                      WrappingContainer(onTap: (){fun(1,2,7);}, letter: UI.isSelected[7] ?  UI.character: "",containerNo: 7,),
                      WrappingContainer(onTap: (){fun(2,2,8);}, letter: UI.isSelected[8] ?  UI.character: "",containerNo: 8,),
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}