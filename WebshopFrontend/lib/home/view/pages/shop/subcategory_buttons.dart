import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constats.dart';


class SubCategoryButtonList extends StatefulWidget {
  const SubCategoryButtonList({Key? key, required this.category, required this.onSubCategorySelected}) : super(key: key);
  final Category category;
  final void Function(SubCategory) onSubCategorySelected;
  @override
  State<SubCategoryButtonList> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategoryButtonList> {
  late SubCategory selectedSubCategory = SubCategory.EMPTY;
  @override
  Widget build(BuildContext context) {
    switch (widget.category) {
      case Category.BAGS:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubSelectionButton(
              selected: selectedSubCategory == SubCategory.EMPTY,
              text: "Alle",
              onPressed: () {
                setState(() {
                  selectedSubCategory =
                  selectedSubCategory == SubCategory.EMPTY ? SubCategory.EMPTY : SubCategory.EMPTY;
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },),
            SizedBox(width: 10,),
            SubSelectionButton(
              selected: selectedSubCategory == SubCategory.BAGS_SHOPPINGBAGS,
              onPressed: () {
                setState(() {
                  selectedSubCategory =
                  selectedSubCategory == SubCategory.BAGS_SHOPPINGBAGS ? SubCategory.EMPTY : SubCategory.BAGS_SHOPPINGBAGS;
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },
              text: 'Einkaufstaschen',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              selected:  selectedSubCategory == SubCategory.BAGS_CROSSOVER,
              onPressed: () {
                setState(() {
                  selectedSubCategory =
                  selectedSubCategory == SubCategory.BAGS_CROSSOVER ? SubCategory.EMPTY : SubCategory.BAGS_CROSSOVER;
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },
              text: 'Umhängetaschen',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              selected: selectedSubCategory == SubCategory.BAGS_SHOULDERBAGS,
              onPressed: () {
                setState(() {
                selectedSubCategory =
                selectedSubCategory == SubCategory.BAGS_SHOULDERBAGS ? SubCategory.EMPTY : SubCategory.BAGS_SHOULDERBAGS;
                widget.onSubCategorySelected(selectedSubCategory);
                });
              },
              text: 'Schultertaschen',
            ),
          ],
        );
      case Category.HATS:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubSelectionButton(
              selected: true,
              text: "Alle",
              onPressed: () {
                setState(() {
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },),
            SizedBox(width: 10,),
            SubSelectionButton(
              selected: true,
              onPressed: () {
                setState(() {
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },
              text: 'Hüte',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              selected: true,
              onPressed: () {
                setState(() {
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },
              text: 'Mützen',
            ),
            SizedBox(width: 10,),
            SubSelectionButton(
              selected: true,
              onPressed: () {
                setState(() {
                  widget.onSubCategorySelected(selectedSubCategory);
                });
              },
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
        return Text('');
    }
  }
}

class SubSelectionButton extends StatelessWidget {
  final text;
   final bool selected;
   final VoidCallback onPressed;

  const SubSelectionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
      ),
      child: Text(text, style: TextStyle( fontSize: 24, decoration: selected ? TextDecoration.underline : TextDecoration.none,
        color: selected ? schemeColorOrange : schemeColorGreen,),),
    );
  }
}
