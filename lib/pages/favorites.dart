import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meals_item.dart';
class Favorites extends StatelessWidget {
  final List<Meal> favoriteMealsList;

  const Favorites(this.favoriteMealsList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMealsList.isEmpty) {
      return const Center(
        child: Text('There is no favorite meals - let\'s add some'),);
    }
    else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id:favoriteMealsList[index].id,
            title: favoriteMealsList[index].title,
            complexity: favoriteMealsList[index].complexity,
            affordability: favoriteMealsList[index].affordability,
            duration: favoriteMealsList[index].duration,
            imageUrl: favoriteMealsList[index].imageUrl,

          );
        },
        itemCount: favoriteMealsList.length,
      );
    }
    }
  }
