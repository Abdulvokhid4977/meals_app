import 'package:flutter/material.dart';

import '../models/dummy_data.dart';
import '../widgets/categories_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(17),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: dummyCategories
            .map((catData) => CategoryItem(catData.color, catData.title,catData.id))
            .toList(),
    );
  }
}
