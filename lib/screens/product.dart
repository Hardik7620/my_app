import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/services/api_service.dart';


class ProductScreen extends StatefulWidget {
  final int subcategoryId;

  const ProductScreen({required this.subcategoryId});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Product>> products;
  int pageIndex = 1;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() {
    apiService.fetchProducts(widget.subcategoryId, pageIndex).then((newProducts) {
      setState(() {
        productList.addAll(newProducts);
        pageIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Product product = productList[index];
          return ListTile(
            title: Text(product.name),
            leading: Image.network(product.imageUrl),
          );
        },
      ),
    );
  }
}
