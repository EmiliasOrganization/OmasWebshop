import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constats.dart';


class SubCategory extends StatefulWidget {
  const SubCategory({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    switch (widget.category) {
      case Category.BAGS:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubSelectionButton(
              text: "Alle",
              onPressed: () {},),
            SizedBox(width: 10,),
            SubSelectionButton(
              onPressed: () {},
              text: 'Einkaufstaschen',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              onPressed: () {},
              text: 'Umhängetaschen',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              onPressed: () {},
              text: 'Schultertaschen',
            ),
          ],
        );
      case Category.HATS:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubSelectionButton(
              text: "Alle",
              onPressed: () {},),
            SizedBox(width: 10,),
            SubSelectionButton(
              onPressed: () {},
              text: 'Hüte',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              onPressed: () {},
              text: 'Mützen',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              onPressed: () {},
              text: 'Stirnbänder',
            ),
          ],
        );
      case Category.CHILDREN:
        return Text('No output available for this category');
      case Category.SOCKS:
        return Text('No output available for this category');
      case Category.CUDDLY_TOYS:
        return Text('No output available for this category');
      case Category.GLOVES:
        return Text('No output available for this category');
      case Category.CUSHIONS:
        return Text('No output available for this category');
      case Category.BACKPACKS:
        return Text('No output available for this category');
      default:
        return Text('No output available for this category');
    }
  }
}

class SubSelectionButton extends StatelessWidget {
  final onPressed;
  final text;
  const SubSelectionButton({
    super.key, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 25, color: schemeColorGreen),),
    );
  }
}
