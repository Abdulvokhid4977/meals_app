import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import '../widgets/meals_item.dart';

class CategoryMealsPage extends StatefulWidget {
  static const mealsRoute = 'category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsPage(this.availableMeals, {Key key}) : super(key: key);

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
String categoryTitle;
List<Meal> categoryMeals;
  @override
  void didChangeDependencies() {
    final routeArgs =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    super.didChangeDependencies();
  }
//   void _removeMeal(String mealId){
// setState(() {
//   categoryMeals.removeWhere((element) => element.id==mealId);
// });
//   }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id:categoryMeals[index].id,
              title: categoryMeals[index].title,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
              duration: categoryMeals[index].duration,
              imageUrl: categoryMeals[index].imageUrl,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
