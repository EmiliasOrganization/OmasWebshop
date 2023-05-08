import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';

class ProductPage extends StatelessWidget {
  final String productId;
  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: Scaffold(
        appBar: TopBar(ueberUns: false,),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Selection
            Container(
              width: 90,
              child: ListView.builder(
                itemCount: 5, // Replace with the actual number of images
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey[300], // Placeholder color
                    child: Center(
                      child: Text('Image ${index + 1}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 20),

            // Big Product Image
            Image.asset("assets/StartScreen.png", height: 600,width: 450, fit: BoxFit.cover,),
            SizedBox(height: 20),
            // Product Details
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price Placeholder',
                    style: TextStyle(
                      fontSize: 18,
                      color: schemeColorGreen,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement add to basket functionality
                    },
                    child: Text('Add to Basket'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement quick checkout functionality
                    },
                    child: Text('Quick Checkout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}