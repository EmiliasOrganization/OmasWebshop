import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/boxes.dart';
import 'package:flutterfrontend/constats.dart';
import 'package:flutterfrontend/globalwidget/centered_view.dart';
import 'package:flutterfrontend/globalwidget/top_bar.dart';
import 'package:flutterfrontend/home/view/pages/cart/cart_items.dart';
import 'package:flutterfrontend/home/view/pages/cart/list_item.dart';
import 'package:flutterfrontend/home/view/pages/produkt/poduct_service.dart';
import 'package:provider/provider.dart';

import '../shop/operators/product_summary_dto.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future <ProductSummary> productData;
  late Future <int> numberOfImages;
  bool itemAdded = false;


  @override
  void initState() {
    super.initState();
    productData = fetchProduct(widget.productId);
    numberOfImages = imageCount(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return FutureBuilder<ProductSummary>(
      future: productData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final productSummary = snapshot.data!;
          return FutureBuilder<int>(
            future: numberOfImages,
            builder: (context, imageSnapshot) {
              if (imageSnapshot.hasData) {
                final int imageCount = imageSnapshot.data!;
                return CenteredView(
                child:
                Scaffold(
                  appBar: TopBar(ueberUns: false,),
                  body: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: double.infinity),
                      // Image Selection
                      Container(
                        width: 90,
                        height: 600,
                        child: ListView.builder(
                          itemCount: imageCount,
                          // Replace with the actual number of images
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                                imageUrl: '$apiPathPicture${widget
                                    .productId}/image${index + 1}',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.scaleDown);
                          })),
                      SizedBox(width: 20),
                      // Big Product Image
                      CachedNetworkImage(
                        imageUrl: '$apiPathPicture${widget.productId}/image1',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
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
                                productSummary.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${productSummary.price}€',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: schemeColorGreen,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${productSummary.description}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                //mit onPressed wird Produkt in boxItemLists und als CartElement gespeichert
                                onPressed: () {
                                  cartProvider.updateItemCount();
                                  //setState neu dazu
                                  setState(() {
                                    boxItemLists.put('key_${productSummary.id}', ListItem(id: widget.productId, name: productSummary.name, description: '${productSummary.description}', price: '${productSummary.price}'));
                                  });
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
              else if (imageSnapshot.hasError) {
                return Text('Error: ${imageSnapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          );
          } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
