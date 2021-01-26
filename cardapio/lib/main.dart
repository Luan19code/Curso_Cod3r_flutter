import 'package:cardapio/data/dummy_data.dart';
import 'package:cardapio/models/settings.dart';
import 'package:cardapio/screens/categories_meals_screens.dart';
import 'package:cardapio/screens/categories_screnn.dart';
import 'package:cardapio/screens/meal_detail_screen.dart';
import 'package:cardapio/screens/tabs_screens.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';
import 'screens/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  //
  //
  List<Meal> _availableMeals = DUMMY_MEALS;
  //
  //
  List<Meal> _favoriteMeals = [];

  void _filterMeal(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: "Raleway",
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (_) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (_) => MealDetailScreen(
              onToggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
        AppRoutes.SETTINGS: (_) => SettingsScreen(_filterMeal, settings),
      },
    );
  }
}
