import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/shop/product_cart.dart';
import 'package:flutterfrontend/home/view/pages/shop/product_summary.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../constats.dart';

Future<List<ProductSummary>> fetchProducts() async {
  final response = await http.get(Uri.parse(apiPathProductSummary));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) =>
        ProductSummary(
            name: json['name'],
            description: json['description'],
            id: json['id']
        )).toList();
  } else {
    throw Exception('Failed to fetch products');
  }
}

// Display the list of products in the UI
class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<ProductSummary>> _productListFuture;

  @override
  void initState() {
    super.initState();
    _productListFuture = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20,top: 20),

      child: FutureBuilder<List<ProductSummary>>(
          future: _productListFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return ProductCard(product: product);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to fetch products'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
    );
  }
}