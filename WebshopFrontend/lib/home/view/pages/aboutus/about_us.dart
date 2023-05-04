import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:carousel_slider/carousel_slider.dart';


// class AboutUs extends StatelessWidget {
//   const AboutUs({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return SizedBox(
//       width: 500,
//       height: 500,
//       child: CarouselSlider(
//         options: CarouselOptions(
//             height: 400.0,
//             autoPlay: true, enlargeCenterPage: true,
//           enlargeFactor: 0.1,),
//
//         items: [1,2,3,4,5].map((i) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                       color: Colors.amber
//                   ),
//                   child: Text('text $i', style: TextStyle(fontSize: 16.0),)
//               );
//             },
//           );
//         }).toList(),
//       ),
//     );
//     // return Stack(
//     //   // alignment: AlignmentDirectional.center,
//     //   children: [
//     //     Positioned(
//     //       top: screenHeight*0.1,
//     //       left: screenWidth*0.05,
//     //       right: 0,
//     //         child: Column(
//     //           children: [
//     //             Row(
//     //               children: [
//     //                 Text('Über uns', textAlign: TextAlign.left, style: TextStyle(
//     //                   fontSize: 30, fontWeight: FontWeight.bold, color: schemeColorGreen,
//     //                 ),),
//     //               ],
//     //             ),
//     //             Row(
//     //               children: [
//     //                 Image(image: AssetImage('assets/StartScreen.png'), width: screenWidth*0.3, height: screenHeight*0.4,)
//     //               ]
//     //             )
//     //           ],
//     //         ),
//     //     ),
//     //     Positioned(
//     //       top: screenHeight*0.5,
//     //       left: screenWidth*0.05,
//     //       child: Column(
//     //         children: [
//     //           Row(
//     //             children: [
//     //               Center(
//     //                 child: IconButton(onPressed: (){},
//     //                   color: schemeColorOrange,
//     //                   icon: const Icon(Icons.arrow_back_ios_sharp),
//     //                   style: IconButton.styleFrom(backgroundColor: Colors.white,
//     //                       side: BorderSide(color: schemeColorGreen)),),
//     //               )
//     //             ],
//     //           ),
//     //         ],
//     //       ),
//     //     )
//     //   ],
//     // );
//   }
// }

class ManuallyControlledSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  bool pressed1 = true;
  bool pressed2 = false;
  bool pressed3 = false;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
            ],
          )),
    ),
  ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
        // appBar: AppBar(title: Text('Über uns')),
        // body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(enlargeCenterPage: true, height: 400),
                carouselController: _controller,
              ),
            ),
            Container(
              width: 1500,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    onPressed: () => _controller.previousPage(),
                    child: Icon(Icons.arrow_back_ios_rounded, color: schemeColorOrange, size:35),
                  ),
                  // OutlinedButton(
                  //   onPressed: () => _controller.previousPage(),
                  //   style: OutlinedButton.styleFrom(
                  //       shape: CircleBorder(),
                  //       padding: EdgeInsets.all(25),
                  //       backgroundColor: Colors.white,
                  //       side: BorderSide(color: schemeColorGreen)
                  //   ),
                  //   child: Text('←'),
                  // ),
                  FloatingActionButton(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    onPressed: () => _controller.nextPage(),
                    child: Icon(Icons.arrow_forward_ios_rounded, color: schemeColorOrange, size:35),
                  ),
                  // OutlinedButton(
                  //   onPressed: () => _controller.nextPage(),
                  //   style: OutlinedButton.styleFrom(
                  //     shape: CircleBorder(),
                  //     padding: EdgeInsets.all(25),
                  //     backgroundColor: Colors.white,
                  //     side: BorderSide(color: schemeColorGreen)
                  //   ),
                  //   child: Text('→'),
                  // ),
                ],
              ),
            ),
            Container(
              width: 800,
              alignment: Alignment(0.0, 0.5),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Flexible(
                    child:TextButton(
                      onPressed:()=> {setState(() {
                        pressed1 = true;
                        pressed2 = false;
                        pressed3 = false;
                      }),
                        _controller.animateToPage(1)},
                      child:Text('Wie alles begann...', style:
                        pressed1 ? TextStyle(color: schemeColorGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: schemeColorGreen)
                                : TextStyle(fontWeight: FontWeight.normal)),
                    ),
                  ),
                  Flexible(
                    child:TextButton(
                      onPressed:()=> {setState(() {
                        pressed2 = true;
                        pressed1 = false;
                        pressed3 = false;
                      }),
                        _controller.animateToPage(2)},
                      child:Text('Wer sind wir?', style:
                        pressed2 ? TextStyle(color: schemeColorGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: schemeColorGreen)
                                 : TextStyle(fontWeight: FontWeight.normal)),
                    ),
                  ),
                  Flexible(
                    child:TextButton(
                      onPressed:()=> {setState(() {
                        pressed3 = true;
                        pressed1 = false;
                        pressed2 = false;
                      }),
                        _controller.animateToPage(3)},
                      child:Text('Unsere Philosophie', style:
                      pressed3 ? TextStyle(color: schemeColorGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: schemeColorGreen)
                               : TextStyle(fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
  }
}


