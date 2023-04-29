import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/home/view/pages/shop/first_shopscreen.dart';


class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      // alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: screenHeight*0.1,
          left: screenWidth*0.05,
          right: 0,
            child: Row(

              children: [
                Text('Über uns', textAlign: TextAlign.left, style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: schemeColorGreen,
                ),)
              ],
            )
        )
      ],
    );
  }
}


