import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Medium,
  Difficult,
}

enum Cost {
  Cheap,
  Fair,
  Expensive,
}

class Meal {
  final String id;
  final String title;
  final String imageUrl;
  //
  //
  final int duration;
  //
  //
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  //
  //
  final List<String> categories;
  final List<String> ingredients;
  final List<String> steps;
  //
  //
  final Complexity complexity;
  final Cost cost;

  const Meal({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.categories,
    @required this.ingredients,
    @required this.steps,
    @required this.complexity,
    @required this.cost,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simples";
        break;
      case Complexity.Medium:
        return "Media";
        break;
      case Complexity.Difficult:
        return "Difícil";
        break;
      default:
        return "Desconhecida";
    }
  }

  String get costText {
    switch (cost) {
      case Cost.Cheap:
        return "Barato";
        break;
      case Cost.Fair:
        return "Justo";
        break;
      case Cost.Expensive:
        return "Caro";
        break;

      default:
        return "Desconhecido";
    }
  }
}
