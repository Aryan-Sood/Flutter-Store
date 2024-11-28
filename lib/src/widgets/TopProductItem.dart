import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/DefaultImage.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/utils/ShowProductModal.dart';

class TopProductItem extends StatelessWidget {
  final Product product;
  const TopProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => showProductModal(context, product),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.images[0],
              height: 250,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(strokeWidth: 1),
              errorWidget: (context, url, error) => CachedNetworkImage(
                imageUrl: DefaultImage.DefaultImageURL,
              ),
            ),
          ),
        )
      ],
    );
  }
}
