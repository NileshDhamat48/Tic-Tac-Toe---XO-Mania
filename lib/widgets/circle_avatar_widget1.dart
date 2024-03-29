import 'package:flutter/material.dart';
import 'package:tictactoexomania/Models/UiLogic.dart';


class CircleAvatarWidget1 extends StatelessWidget {

  final imageName,color,onTap;
  CircleAvatarWidget1({this.imageName,this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
            radius: 23.0,
            backgroundColor: UI.avatar1Map[imageName],
            child: LayoutBuilder(
              builder: (context,constraints) => Image(
                image: AssetImage("images/$imageName.png"),
                height: constraints.maxHeight * 0.85,
                width : constraints.maxWidth * 0.85,
              ),
            ),
        ),
    );
  }
}