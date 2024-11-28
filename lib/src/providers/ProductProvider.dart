import 'package:flutter/material.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/services/APIService.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;

  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();

      final fetchedProducts = await APIService.fetchData();
      _products = fetchedProducts;

    } catch (error) {
      print('Error fetching products: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}