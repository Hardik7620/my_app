import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/services/api_service.dart';

import 'sub_category_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();
    categories = apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESP Tiles'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: FutureBuilder<List<Category>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Category> categoryList = snapshot.data!;
            return ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                Category category = categoryList[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    // Only show data for Ceramic category
                    if (category.name.toLowerCase() == 'ceramic') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubcategoryScreen(categoryId: category.id),
                        ),
                      );
                    }
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load categories'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
