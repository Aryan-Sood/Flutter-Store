import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store/src/models/Category.dart';
import 'package:store/src/models/Product.dart';

class APIService {
  static const String BASE_API_URL = 'https://api.escuelajs.co/api/v1/products';

  static Future<List<Product>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(BASE_API_URL));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        List<Product> allProducts = [];

        data.forEach((item){
          allProducts.add(Product(
          id: item['id'],
          title: item['title'],
          price: item['price'],
          description: item['description'],
          images: item['images'],
          category: Category(
            id: item['category']['id'],
            name: item['category']['name'],
            image: item['category']['image'])));
        });

        return allProducts;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching products: $error');
    }
  }
}
