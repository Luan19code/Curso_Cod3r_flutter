import 'package:cardapio/components/meal_item.dart';
import 'package:cardapio/models/meal.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  const MealDetailScreen({Key key, this.onToggleFavorite, this.isFavorite})
      : super(key: key);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 350,
      height: 300,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 600,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _createSectionTitle(context, "Ingredientes"),
                    _createSectionContainer(
                      ListView.builder(
                        itemCount: meal.ingredients.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(child: Text(meal.ingredients[index])),
                            ),
                            color: Theme.of(context).accentColor,
                          );
                        },
                      ),
                    ),
                    _createSectionTitle(context, "Passos"),
                    _createSectionContainer(
                      ListView.builder(
                        itemCount: meal.steps.length,
                        itemBuilder: (context, index) {
                          //       print("object");

                          return Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  child: Text('${index + 1}'),
                                ),
                                title: Text(meal.steps[index]),
                              ),
                              Divider(
                                height: 30,
                                color: Colors.amber,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onToggleFavorite(meal);
        },
        child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
