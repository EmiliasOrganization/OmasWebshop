import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constats.dart';

class SubCategoryButtonList extends StatefulWidget {
  const SubCategoryButtonList({Key? key, required this.category, required this.onSubCategorySelected})
      : super(key: key);

  final Category category;
  final void Function(SubCategory) onSubCategorySelected;

  @override
  State<SubCategoryButtonList> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategoryButtonList> {
  late SubCategory selectedSubCategory = SubCategory.EMPTY;

  @override
  void didUpdateWidget(covariant SubCategoryButtonList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.category != oldWidget.category) {
      setState(() {
        selectedSubCategory = SubCategory.EMPTY;
      });
    }
  }

  void updateSelectedSubCategory(SubCategory subCategory) {
    setState(() {
      selectedSubCategory = selectedSubCategory == subCategory ? SubCategory.EMPTY : subCategory;
      widget.onSubCategorySelected(selectedSubCategory);
    });
  }

  Widget buildSubSelectionButton(SubCategory subCategory, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SubSelectionButton(
        onPressed: () => updateSelectedSubCategory(subCategory),
        text: text,
        selected: selectedSubCategory == subCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildSubCategoryButtons(),
    );
  }

  List<Widget> buildSubCategoryButtons() {
    final buttons = <Widget>[];

    switch (widget.category) {
      case Category.BAGS:
        buttons.addAll([
          buildSubSelectionButton(SubCategory.EMPTY, "Alle"),
          buildSubSelectionButton(SubCategory.BAGS_SHOPPINGBAGS, "Einkaufstaschen"),
          buildSubSelectionButton(SubCategory.BAGS_CROSSOVERS, "Umhängetaschen"),
          buildSubSelectionButton(SubCategory.BAGS_SHOULDERBAGS, "Schultertaschen"),
        ]);
        break;
      case Category.HATS:
        buttons.addAll([
          buildSubSelectionButton(SubCategory.EMPTY, "Alle"),
          buildSubSelectionButton(SubCategory.HATS_HATS, "Hüte"),
          buildSubSelectionButton(SubCategory.HATS_TOQUES, "Mützen"),
          buildSubSelectionButton(SubCategory.HATS_HEADBANDS, "Stirnbänder"),
        ]);
        break;
      case Category.CHILDREN:
        buttons.add(Text('No output available for this category'));
        break;
      case Category.SOCKS:
        buttons.add(Text('No output available for this category'));
        break;
      case Category.CUDDLY_TOYS:
        buttons.add(Text('No output available for this category'));
        break;
      case Category.GLOVES:
        buttons.add(Text('No output available for this category'));
        break;
      case Category.CUSHIONS:
        buttons.add(Text('No output available for this category'));
        break;
      case Category.BACKPACKS:
        buttons.add(Text('No output available for this category'));
        break;
      default:
        buttons.add(Text('No output available for this category'));
        break;
    }

    return buttons;
  }
}

class SubSelectionButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onPressed;

  const SubSelectionButton({
    required this.onPressed,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          decoration: selected ? TextDecoration.underline : TextDecoration.none,
          color: selected ? schemeColorOrange : schemeColorGreen,
        ),
      ),
    );
  }
}
