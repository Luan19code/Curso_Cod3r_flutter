import 'package:cardapio/models/category.dart';
import 'package:cardapio/screens/categories_meals_screens.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _selectCategory(BuildContext context) {
      Navigator.of(context).pushNamed(
        AppRoutes.CATEGORIES_MEALS,
        arguments: category,
      );
    }

    return InkWell(
      onTap: () => _selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(
            category.title,
          ),
        ),
      ),
    );
  }
}
