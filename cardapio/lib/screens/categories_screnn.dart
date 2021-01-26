import 'package:cardapio/components/category_item.dart';
import 'package:cardapio/data/dummy_data.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES.map((cat) {
        return Container(
          //   color: Colors.red,

          child: 
          CategoryItem(
            category: cat,
          ),
        );
      }).toList(),
    );
  }
}
