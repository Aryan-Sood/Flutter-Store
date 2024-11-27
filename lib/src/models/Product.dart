import 'package:store/src/models/Category.dart';

class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<dynamic> images;
  final Category category;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.images,
      required this.category});
}
