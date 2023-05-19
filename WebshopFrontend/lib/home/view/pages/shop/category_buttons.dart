

import 'package:flutter/material.dart';

import '../../../../constats.dart';


class ButtonList extends StatefulWidget {
  final Category? category;
  final void Function(Category) onCategorySelected;

  const ButtonList({
    Key? key,
    required this.category,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  late Category selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category ?? Category.EMPTY;
  }

  void updateSelectedCategory(Category category) {
    setState(() {
      selectedCategory = selectedCategory == category ? Category.EMPTY : category;
      widget.onCategorySelected(selectedCategory);
    });
  }

  Widget buildCategoryButton(String buttonName, Category category) {
    return SizedBox(
      height: 80,
      width: 210,
      child: CategoryButton(
        buttonName: buttonName,
        selected: selectedCategory == category,
        onPressed: () => updateSelectedCategory(category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCategoryButton('Alles', Category.EMPTY),
        SizedBox(height: 20),
        buildCategoryButton('Taschen', Category.BAGS),
        SizedBox(height: 20),
        buildCategoryButton('Kopfbedeckungen', Category.HATS),
        SizedBox(height: 20),
        buildCategoryButton('Kinder', Category.CHILDREN),
        SizedBox(height: 20),
        buildCategoryButton('Socken', Category.SOCKS),
        SizedBox(height: 20),
        buildCategoryButton('Kuscheltiere', Category.CUDDLY_TOYS),
        SizedBox(height: 20),
        buildCategoryButton('Handschuhe', Category.GLOVES),
        SizedBox(height: 20),
        buildCategoryButton('Kissen & Decken', Category.CUSHIONS),
        SizedBox(height: 15),
        buildCategoryButton('Rucksäcke', Category.BACKPACKS),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;
  final String buttonName;

  const CategoryButton({
    Key? key,
    required this.selected,
    required this.onPressed,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(210, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        foregroundColor: schemeColorMistyRose,
        backgroundColor: selected ? schemeColorOrange : schemeColorGreen,
      ),
      onPressed: onPressed,
      child: Text(buttonName, style: TextStyle(fontSize: 20)),
    );
  }
}


