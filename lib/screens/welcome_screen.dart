import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/widgets/showcasewidget.dart';
import 'package:tictactoexomania/screens/pickup_screen.dart';
import 'package:tictactoexomania/widgets/reusable_button.dart';
import 'package:tictactoexomania/widgets/wp_screen_text_widget.dart';
import 'dart:io';

import 'game_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final keyOne = GlobalKey();
  AppOpenAdManager1 appOpenAdManager = AppOpenAdManager1();
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

    appOpenAdManager.loadAd();
    Future.delayed(const Duration(seconds: 10), () {
      appOpenAdManager.showAdIfAvailable();
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context).startShowCase([keyOne]),
    );

    super.initState();
  }
  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _ad?.dispose();
    super.dispose();
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
            if (_ad != null)
              Container(
                width: _ad!.size.width.toDouble(),
                height: _ad!.size.height.toDouble(),
                alignment: Alignment.center,
                child: AdWidget(ad: _ad!),
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

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return Constant.BANNER_ADS;
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5270778529330824/2878526733';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
class AppOpenAdManager1 {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  static bool isLoaded=false;

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: Constant.APP_OPEN_ADS,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print("Ad Loadede.................................");
          _appOpenAd = ad;
          isLoaded=true;
        },
        onAdFailedToLoad: (error) {
          // Handle the error.
        },
      ),
    );
  }

  // Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    print("Called=====================================================================");
    if (_appOpenAd == null) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd?.show();
  }
}
