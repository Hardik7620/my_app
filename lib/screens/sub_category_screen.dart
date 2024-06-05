import 'package:flutter/material.dart';
import 'package:my_app/models/sub_category.dart';
import 'package:my_app/services/api_service.dart';

import 'product.dart';


class SubcategoryScreen extends StatefulWidget {
  final int categoryId;

  const SubcategoryScreen({super.key, required this.categoryId});

  @override
  _SubcategoryScreenState createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Subcategory>> subcategories;
  int pageIndex = 1;
  List<Subcategory> subcategoryList = [];

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
  }

  void fetchSubcategories() {
    apiService.fetchSubcategories(widget.categoryId, pageIndex).then((newSubcategories) {
      setState(() {
        subcategoryList.addAll(newSubcategories);
        pageIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subcategories'),
      ),
      body: ListView.builder(
        itemCount: subcategoryList.length,
        itemBuilder: (context, index) {
          Subcategory subcategory = subcategoryList[index];
          return ListTile(
            title: Text(subcategory.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(subcategoryId: subcategory.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
