import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutterfrontend/home/view/pages/shop/operators/product_summary_dto.dart';
import 'package:http/http.dart' as http;
import '../../../../../constats.dart';


Future<List<ProductSummary>> fetchProducts({Category category = Category.EMPTY,SubCategory subCategory = SubCategory.EMPTY}) async {
  String subCategoryEnumName = subCategory.toString().split('.').last;
  String categoryEnumName = category.toString().split('.').last;
  http.Response response;

  if(subCategory != SubCategory.EMPTY){
    if(category != Category.EMPTY){
      response = await http.get(Uri.parse('$apiPathCategoryAndOrSubCategory/$categoryEnumName/$subCategoryEnumName'));
    }
    else {response = await http.get(Uri.parse('$apiPathOnlySubCategory/$subCategoryEnumName'));}
  } else
    if(category != Category.EMPTY){
    response = await http.get(Uri.parse('$apiPathCategoryAndOrSubCategory/$categoryEnumName'));
  }
  else {response = await http.get(Uri.parse(apiPathProductSummary));}

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) =>
        ProductSummary(
            name: json['name'],
            description: json['description'],
            id: json['id'],
            category: json['category'],
            subCategory: json['subCategory'],
            price: Decimal.parse(json['price']),
        )).toList();
  } else {
    throw Exception('Failed to fetch products${response.statusCode}');
  }
}
