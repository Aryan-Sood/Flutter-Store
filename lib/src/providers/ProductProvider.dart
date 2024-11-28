import 'package:flutter/material.dart';
import 'package:store/src/models/Product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _allProducts = [];

  List<Product> get getProducts => _allProducts;

  void setProducts(List<Product> newProducts) {
    _allProducts = newProducts;
    notifyListeners();
  }
}
