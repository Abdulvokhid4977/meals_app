import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';
import './categories_page.dart';
import './favorites.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoriteMealsList;

  const TabsPage(this.favoriteMealsList, {Key key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  @override
  void initState() {
    _pages=[
      {'pages': const CategoriesPage(), 'title': 'Categories'},
      {'pages':  Favorites(widget.favoriteMealsList), 'title': 'Your Favorite'},
    ];
    super.initState();
  }List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: const Drawer(child: MainDrawer()),
      body: _pages[_selectedPageIndex]['pages'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
