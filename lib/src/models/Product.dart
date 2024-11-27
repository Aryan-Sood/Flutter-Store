import 'package:store/src/models/Category.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final Category category;

  Product({
  required this.id,
  required this.title,
  required this.price,
  required this.description,
  required this.images,
  required this.category
  });

}