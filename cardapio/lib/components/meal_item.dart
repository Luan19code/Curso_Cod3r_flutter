import 'package:cardapio/models/meal.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  MealItem(this.meal);

  void _selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      AppRoutes.MEAL_DETAIL,
      arguments: meal,
    )
        .then((value) {
      Meal meal;
      if (value == null) {
        print("Sem Resultado");
      } else {
        meal = value;
        print(meal.imageUrl);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        _selectMeal(context);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  tituloImagem(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text("${meal.duration} min "),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text("${meal.complexityText} "),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text("${meal.costText} "),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tituloImagem() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        width: 300,
        color: Colors.black45,
        child: Text(
          meal.title,
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
          ),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
