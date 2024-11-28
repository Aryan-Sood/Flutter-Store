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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      images: json['image'] as List,
      category: json['category'] as Category,
    );
  }
    
    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': images,
      'category': category,
    };
  }
}
