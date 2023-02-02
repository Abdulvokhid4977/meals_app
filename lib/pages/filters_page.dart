import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routName = 'filters';
  final Function saveFilters;
  final Map<String, bool> filters;
  FiltersPage(this.saveFilters,this.filters, {Key key}) : super(key: key);
  @override
  State<FiltersPage> createState() => _FiltersPageState();

}

class _FiltersPageState extends State<FiltersPage> {
  var isGlutenFree = false;
  var isLactoseFree = false;
  var isVegan = false;
  var isVegetarian = false;
  @override
  void initState() {
    isGlutenFree=widget.filters['gluten'];
    isLactoseFree=widget.filters['lactose'];
    isVegan=widget.filters['vegan'];
    isVegetarian=widget.filters['vegetarian'];
    super.initState();
  }
  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': isGlutenFree,
                'lactose': isLactoseFree,
                'vegan': isVegan,
                'vegetarian': isVegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: const Drawer(child: MainDrawer()),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile('Gluten-free',
                    'Only include gluten-free meals', isGlutenFree, (newValue) {
                  setState(() {
                    isGlutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    isLactoseFree, (newValue) {
                  setState(() {
                    isLactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only include vegetarian meals', isVegetarian,
                    (newValue) {
                  setState(() {
                    isVegetarian = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include vegan meals', isVegan, (newValue) {
                  setState(() {
                    isVegan = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
