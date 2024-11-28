import 'package:flutter/material.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/utils/ProductConverter.dart';
import 'package:store/src/widgets/ProductListItem.dart';

class HomePageList extends StatelessWidget {
  final dynamic items;
  final Function showProductModal;
  const HomePageList(
      {super.key, required this.items, required this.showProductModal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final Product product = ProductDataConversion(items[index]);
            return ProductListItem(
                product: product,
                tapProvider: showProductModal,
                parentContext: context);
          }),
    );
  }
}
