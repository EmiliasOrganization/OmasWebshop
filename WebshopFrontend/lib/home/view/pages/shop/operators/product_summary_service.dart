import 'dart:convert';

import 'package:flutterfrontend/home/view/pages/shop/operators/product_summary_dto.dart';
import 'package:http/http.dart' as http;

import '../../../../../constats.dart';


Future<List<ProductSummary>> fetchAllProducts() async {
  final response = await http.get(Uri.parse(apiPathProductSummary));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) =>
        ProductSummary(
            name: json['name'],
            description: json['description'],
            id: json['id'],
            category: json['category'],
        )).toList();
  } else {
    throw Exception('Failed to fetch products');
  }
}