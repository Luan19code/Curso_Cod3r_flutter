import 'package:cardapio/components/meal_item.dart';
import 'package:cardapio/data/dummy_data.dart';
import 'package:cardapio/models/category.dart';
import 'package:cardapio/models/meal.dart';
import 'package:flutter/material.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoriesMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    //
    //
    final category = ModalRoute.of(context).settings.arguments as Category;
    //
    //
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    //
    //
    // print(categoryMeals[0].isVegan);
    //
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${category.title}",
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (_, index) {
          return MealItem(categoryMeals[index]);
        },
      ),
    );
  }
}
