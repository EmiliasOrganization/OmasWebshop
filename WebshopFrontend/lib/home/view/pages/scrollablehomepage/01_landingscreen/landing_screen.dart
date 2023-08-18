import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';



class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key, required this.itemScrollController}) : super(key: key);

  final ItemScrollController itemScrollController;

  @override
  State<StatefulWidget> createState() => _LandingScreenState();

  }

class _LandingScreenState extends State<LandingScreen>{


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.05;
    const maxFontSizeHeadline = 30.0;
    const maxFontSizeText = 20.0;


    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          if(constraints.maxWidth > 800) {
            return buildBigScreenLayout(theme, fontSize, maxFontSizeHeadline, maxFontSizeText, widget.itemScrollController);
          }
          else {
            return buildSmallScreenLayout(theme, fontSize, maxFontSizeHeadline, maxFontSizeText, widget.itemScrollController);
          }
        }
    );
    //  return NormalSizePage(theme: theme);
  }
}

  Widget buildSmallScreenLayout(final theme, final fontSize, final maxFontSizeHeadline, final maxFontSizeText, final ItemScrollController itemScrollController) {
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.easeInOut,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'http://localhost:8080/api/shop/picture/c0a8982c-87d8-1f83-8187-d80f95c20000',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Kodchasan',
                fontSize: fontSize.clamp(0, maxFontSizeHeadline) * 0.8,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Handgemacht um zu begeistern',
                style: TextStyle(
                  fontFamily: 'Kodchasan',
                  fontSize: fontSize.clamp(0, maxFontSizeText) * 0.8,
                ),
              ),
            ),

        ElevatedButton(
          child: (Text('Zum Laden')),
          onPressed: () {
            itemScrollController.scrollTo(
                index: 1, duration: Duration(seconds: 1), curve: Curves.easeInOut);

          },
        ),
          ],
        ),
      ),
    );
  }

  Widget buildBigScreenLayout(final theme, final fontSize, final maxFontSizeHeadline, final maxFontSizeText, final ItemScrollController itemScrollController) {
    return AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.easeInOut,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              'Strickperson.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Kodchasan',
                      fontSize: fontSize.clamp(0, 120),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Handgemacht um zu begeistern',
                    style: TextStyle(
                      fontFamily: 'Kodchasan',
                      fontSize: fontSize.clamp(0, 50),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200,60),
                    ),
                    child: (Text('Zum Laden')),
                    onPressed: () {
                      itemScrollController.scrollTo(
                          index: 1, duration: Duration(seconds: 1), curve: Curves.easeInOut);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }





