import 'package:flutter/material.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/views/ModalSheet.dart';

void showProductModal(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return ProductModalSheet(product: product);
    },
  );
}
