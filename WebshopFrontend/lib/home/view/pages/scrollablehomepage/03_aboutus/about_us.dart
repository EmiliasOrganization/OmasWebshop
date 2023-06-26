import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ManuallyControlledSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  List <String> elementName = ['Wie alles begann...', 'Wer sind wir?', 'Unsere Philosophie'];
  late String buttonState = elementName.first;


  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
              ],
            )),
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
                width: 1500,
                height:700,
                alignment: Alignment.topLeft,
                child: Text('Über uns', style: TextStyle(color: schemeColorGreen, fontSize: 40, fontWeight: FontWeight.bold),)
            ),
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
                    heroTag: "btn1",
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    onPressed: () => _controller.previousPage(),
                    child: Icon(Icons.arrow_back_ios_rounded, color: schemeColorOrange, size:35),
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    onPressed: () => _controller.nextPage(),
                    child: Icon(Icons.arrow_forward_ios_rounded, color: schemeColorOrange, size:35),
                  ),
                ],
              ),
            ),
            Container(
              width: 800,
              alignment: Alignment(0.0, 0.5),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  AboutUsCarouselButton(
                    text: elementName[0],
                    selected: elementName[0] == buttonState,
                    onPressed: () => {
                      _controller.animateToPage(1),
                      setState ((){
                        buttonState = elementName[0];
                      }),
                    },
                  ),
                  AboutUsCarouselButton(
                    text: elementName[1],
                    selected: elementName[1] == buttonState,
                    onPressed: () => {
                      _controller.animateToPage(2),
                      setState ((){
                        buttonState = elementName[1];
                      }),
                    },
                  ),
                  AboutUsCarouselButton(
                    text: elementName[2],
                    selected: elementName[2] == buttonState,
                    onPressed: () => {
                      _controller.animateToPage(3),
                      setState ((){
                        buttonState = elementName[2];
                      }),
                    },
                  ),
                ],
              ),
            )
          ],
        );
  }
}

class AboutUsCarouselButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool selected;
  final String text;
  const AboutUsCarouselButton({Key? key,
    required this.onPressed, required this.selected, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child:TextButton(
        onPressed: onPressed,
        child:Text(text, style:
        selected ? TextStyle(color: schemeColorGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: schemeColorGreen)
            : TextStyle(fontWeight: FontWeight.normal)),
      ),
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

