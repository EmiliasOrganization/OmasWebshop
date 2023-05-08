import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/produkt/poduct_service.dart';

import '../shop/operators/product_summary_dto.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future <ProductSummary> productData;
  @override
  Widget build(BuildContext context) {
    productData = fetchProduct(widget.productId);
    print(productData);
    return CenteredView(
      child:
      Scaffold(
        appBar: TopBar(ueberUns: false,),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height : double.infinity),
            // Image Selection
            Container(
              width: 90,
              height: 600,
              child: ListView.builder(
                itemCount: 7, // Replace with the actual number of images
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
            CachedNetworkImage(imageUrl: '$apiPathPicture${widget.productId}/image1',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 600,
              width: 450,
              fit: BoxFit.fitHeight,),
            SizedBox(width: 80),
            // Product Details
            Container(
              height: 600,
              child: Padding(
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
                      'productData.price as String',
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
                      child: Text('Dem Warenkorb hinzufügen'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement quick checkout functionality
                      },
                      child: Text('Direkt zur Kasse'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
