import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import '../models/meal.dart';
import '../pages/filters_page.dart';
import '../pages/meal_detail_page.dart';
import '../pages/tabs_page.dart';
import '../pages/categories_meals_page.dart';

import '../pages/categories_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _markedAsFavorite = [];

  void _favoriteMeals(String mealID) {
    final indexOfElement =
        _markedAsFavorite.indexWhere((element) => element.id == mealID);
    if (indexOfElement >= 0) {
      setState(() {
        _markedAsFavorite.removeAt(indexOfElement);
      });
    } else {
      _markedAsFavorite.add(dummyMeals.firstWhere((meal) => meal.id == mealID));
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
bool iconChange(String id){
    return _markedAsFavorite.any((meal) => meal.id==id);

}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                subtitle1: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.yellowAccent.shade700),
        ),
        routes: {
          '/': (ctx) => TabsPage(_markedAsFavorite),
          CategoryMealsPage.mealsRoute: (ctx) =>
              CategoryMealsPage(_availableMeals),
          MealDetailScreen.routeName: (ctx) => MealDetailScreen(_favoriteMeals, iconChange),
          FiltersPage.routName: (ctx) => FiltersPage(_setFilters, _filters),
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => const CategoriesPage());
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (builder) => const CategoriesPage());
        });
  }
}
