import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/models/category.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/models/sub_category.dart';


class ApiService {
  final String baseUrl = 'http://esptiles.imperoserver.in/api/API/Product/';

  Future<List<Category>> fetchCategories() async {
    final response = await http.post(
      Uri.parse('${baseUrl}DashBoard'),
      body: jsonEncode({
        'CategoryId': 0,
        'DeviceManufacturer': 'Google',
        'DeviceModel': 'Android SDK built for x86',
        'DeviceToken': '',
        'PageIndex': 1
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Subcategory>> fetchSubcategories(int categoryId, int pageIndex) async {
    final response = await http.post(
      Uri.parse('${baseUrl}DashBoard'),
      body: jsonEncode({
        'CategoryId': categoryId,
        'PageIndex': pageIndex,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<List<Product>> fetchProducts(int subcategoryId, int pageIndex) async {
    final response = await http.post(
      Uri.parse('${baseUrl}ProductList'),
      body: jsonEncode({
        'SubCategoryId': subcategoryId,
        'PageIndex': pageIndex,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
