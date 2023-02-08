import 'package:flutter/material.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/widgets/circle_avatar_widget2.dart';

class RowAvatarImages2 extends StatefulWidget {

  @override
  _RowAvatarImages2State createState() => _RowAvatarImages2State();
}

class _RowAvatarImages2State extends State<RowAvatarImages2> {

  @override
  Widget build(BuildContext context) {

    void toggleColor(String name){
      UI.avatar2Map.keys.forEach((key){
        UI.avatar2Map[key] = kGameScreenBackgroundColor1;
      });
      setState(() {
        UI.avatar2Map[name] = kGameScreenBackgroundColor2;
        UI.player2ImageName = name;
      });
    }

    return Row(
      children: [
        Text("Avatar",style: kSettingsBoxLetterStyle,),

        Expanded(child: CircleAvatarWidget2(imageName: 'avatar-5',onTap: () => toggleColor('avatar-5'))),
        Expanded(child: CircleAvatarWidget2(imageName: 'avatar-7',onTap: () => toggleColor('avatar-7'))),
        Expanded(child: CircleAvatarWidget2(imageName: 'avatar-9',onTap: () => toggleColor('avatar-9'))),
        Expanded(child: CircleAvatarWidget2(imageName: 'avatar-12',onTap: () => toggleColor('avatar-12'))),
        Expanded(child: CircleAvatarWidget2(imageName: 'avatar-13',onTap: () => toggleColor('avatar-13'))),
        Expanded(child: CircleAvatarWidget2(imageName: 'avatar-14',onTap: () => toggleColor('avatar-14'))),
      ],
    );
  }
}
