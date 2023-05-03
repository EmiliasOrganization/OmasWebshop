import 'package:flutter/material.dart';
import 'package:flutterfrontend/home/view/pages/shop/category_buttons.dart';
import 'package:flutterfrontend/home/view/pages/shop/product_cart.dart';
import 'package:flutterfrontend/home/view/pages/shop/operators/product_summary_dto.dart';
import 'package:flutterfrontend/home/view/pages/shop/operators/product_summary_service.dart';
import 'package:flutterfrontend/home/view/pages/shop/subcategory_buttons.dart';

import '../../../../constats.dart';



// Display the list of products in the UI
class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<ProductSummary>> _productListFuture;
  late Category category = ModalRoute
      .of(context)!
      .settings
      .arguments as Category? ?? Category.EMPTY;
  var isFirstLoad = true;

  Category newCategory = Category.EMPTY;

  void _onCategorySelected(Category category) {
    setState(() {
      newCategory = category;
    });
  }

  @override
  void initState() {
    super.initState();
    _productListFuture = fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (isFirstLoad) {
        isFirstLoad = false;
        newCategory = ModalRoute
            .of(context)!
            .settings
            .arguments as Category? ?? Category.EMPTY;
      }
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: ButtonList(category: category,
                  onCategorySelected: _onCategorySelected),),
            //  ShopList(productListFuture: _productListFuture),
          ],
        ),
        Expanded(
          child: Container(
              alignment: Alignment.bottomCenter,
              height: 75,
              child: SubCategory(category: newCategory)
          ),
        ),
      ],
    );
  }
}


class ShopList extends StatelessWidget {
  const ShopList({
    super.key,
    required Future<List<ProductSummary>> productListFuture,
  }) : _productListFuture = productListFuture;

  final Future<List<ProductSummary>> _productListFuture;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30,top: 20),

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
                    crossAxisSpacing: 45,
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
      ),
    );
  }
}
