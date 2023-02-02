import 'package:flutter/material.dart';
import '../models/dummy_data.dart';

class MealDetailScreen extends StatefulWidget {

  static const routeName = 'meal-detail';

  final Function favoriteMeals;
  final Function isFavorite;
  const MealDetailScreen(this.favoriteMeals,this.isFavorite, {Key key}) : super(key: key);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildText(BuildContext context, text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildContainer(Widget widget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            buildText(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  child: Text(
                      '#${index + 1}   ${selectedMeal.ingredients[index]}'),
                ),
              ),
            ),
            buildText(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          setState(() {
            widget.favoriteMeals(mealId);
          });
        } ,
        child: Icon(widget.isFavorite(mealId)? Icons.star : Icons.star_border),
      ),
    );
  }
}
