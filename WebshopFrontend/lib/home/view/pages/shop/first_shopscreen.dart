import 'package:flutter/material.dart';

class FirstShopScreen extends StatelessWidget {

  //TODO: Refactor Button in one Widget
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          left: 0,
          right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFFFA54F),
                    backgroundColor: Color(0xff4A6840),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                      minimumSize: Size(150, 50),
                  ),
                    onPressed: (){},
                    child: Text('Taschen & Rucksäcke')
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFA54F),
                      backgroundColor: Color(0xff4A6840),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: (){},
                    child: Text('Kopfbedeckung')
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFA54F),
                      backgroundColor: Color(0xff4A6840),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: (){},
                    child: Text('Kinder & Baby\'s')
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFA54F),
                      backgroundColor: Color(0xff4A6840),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: (){},
                    child: Text('Kissen & Decken')
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFA54F),
                      backgroundColor: Color(0xff4A6840),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: (){},
                    child: Text('Kuscheltiere')
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFA54F),
                      backgroundColor: Color(0xff4A6840),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: (){},
                    child: Text('Socken')
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFFFA54F),
                      backgroundColor: Color(0xff4A6840),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: (){},
                    child: Text('Schals & Tücher')
                ),
              ],
            ),
          ),

        Center(
          child: Text('Hello, World!'),
        ),
      ],
    );
  }
}