import 'package:flutter/cupertino.dart';
import 'package:flutterfrontend/globalwidget/roundet_text_picture.dart';

class FourPictureRowClickable extends StatelessWidget {
  const FourPictureRowClickable({
    super.key,
    required this.topPosition,
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture1,
    required this.picture2,
    required this.picture3,
    required this.picture4,
    required this.headLineText1,
    required this.headLineText2,
    required this.headLineText3,
    required this.headLineText4,
    required this.routePath1,
    required this.routePath2,
    required this.routePath3,
    required this.routePath4
  });

  final topPosition;
  final pictureSizeWidth;
  final pictureSizeHeight;
  final picture1;
  final picture2;
  final picture3;
  final picture4;
  final headLineText1;
  final headLineText2;
  final headLineText3;
  final headLineText4;
  final routePath1;
  final routePath2;
  final routePath3;
  final routePath4;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundetTextPicture(
              pictureSizeWidth: pictureSizeWidth,
              pictureSizeHeight: pictureSizeHeight,
              picture: picture1,
              headLineText: headLineText1,
              routePath: routePath1,
          ),
          SizedBox(width: 20),
          RoundetTextPicture(
              pictureSizeWidth: pictureSizeWidth,
              pictureSizeHeight: pictureSizeHeight,
              picture: picture2,
              headLineText: headLineText2,
              routePath: routePath2,
          ),
          SizedBox(width: 20),
          RoundetTextPicture(
              pictureSizeWidth: pictureSizeWidth,
              pictureSizeHeight: pictureSizeHeight,
              picture: picture3,
              headLineText: headLineText3,
              routePath: routePath3,
          ),
          SizedBox(width: 20),
          RoundetTextPicture(
            pictureSizeWidth: pictureSizeWidth,
            pictureSizeHeight: pictureSizeHeight,
            picture: picture4,
            headLineText: headLineText4,
            routePath: routePath4,
          ),
        ],
      ),
    );
  }
}


class TwoPictureRowClickable extends StatelessWidget {
  const TwoPictureRowClickable({
    super.key,
    required this.topPosition,
    required this.pictureSizeWidth,
    required this.pictureSizeHeight,
    required this.picture1,
    required this.picture2,
    required this.headLineText1,
    required this.headLineText2,
    required this.routePath1,
    required this.routhePath2,
  });

  final topPosition;
  final pictureSizeWidth;
  final pictureSizeHeight;
  final picture1;
  final picture2;
  final headLineText1;
  final headLineText2;
  final routePath1;
  final routhePath2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundetTextPicture(pictureSizeWidth: pictureSizeWidth, pictureSizeHeight: pictureSizeHeight, picture: picture1, headLineText: headLineText1, routePath: routePath1,),
          SizedBox(width: 20),
          RoundetTextPicture(pictureSizeWidth: pictureSizeWidth, pictureSizeHeight: pictureSizeHeight, picture: picture2, headLineText: headLineText2, routePath: routhePath2,),
        ],
      ),
    );
  }
}