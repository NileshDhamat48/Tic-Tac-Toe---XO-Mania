import 'package:flutter/material.dart';
import 'package:tictactoexomania/widgets/circle_avatar_widget1.dart';
import 'package:tictactoexomania/constants.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';

class RowAvatarImages1 extends StatefulWidget{

  @override
  _RowAvatarImages1State createState() => _RowAvatarImages1State();
}

class _RowAvatarImages1State extends State<RowAvatarImages1> {

  @override
  Widget build(BuildContext context) {

    void toggleColor(String name){

      UI.avatar1Map.keys.forEach((key){
        UI.avatar1Map[key] = kGameScreenBackgroundColor1;
      });

      setState(() {
        UI.avatar1Map[name] = kGameScreenBackgroundColor2;
        UI.player1ImageName = name;
      });
    }

    return Row(
        children: [
          Text("Avatar",style: kSettingsBoxLetterStyle),

          Expanded(child: CircleAvatarWidget1(imageName: 'avatar-5',onTap: () => toggleColor('avatar-5'))),
          Expanded(child: CircleAvatarWidget1(imageName: 'avatar-7',onTap: () => toggleColor('avatar-7'))),
          Expanded(child: CircleAvatarWidget1(imageName: 'avatar-9',onTap: () => toggleColor('avatar-9'))),
          Expanded(child: CircleAvatarWidget1(imageName: 'avatar-12',onTap: () => toggleColor('avatar-12'))),
          Expanded(child: CircleAvatarWidget1(imageName: 'avatar-13',onTap: () => toggleColor('avatar-13'))),
          Expanded(child: CircleAvatarWidget1(imageName: 'avatar-14',onTap: () => toggleColor('avatar-14'))),
        ],
      );
  }
}

