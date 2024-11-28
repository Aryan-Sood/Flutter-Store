import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/constants/DefaultImage.dart';

class ProductListItem extends StatefulWidget {
  final Product product;
  final Function tapProvider;
  final BuildContext parentContext;
  const ProductListItem(
      {super.key,
      required this.product,
      required this.tapProvider,
      required this.parentContext});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () => widget.tapProvider(widget.parentContext, widget.product),
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: widget.product.images[0],
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const CircularProgressIndicator(strokeWidth: 1),
            errorWidget: (context, url, error) => CachedNetworkImage(
              imageUrl: DefaultImage.DefaultImageURL,
            ),
          ),
        ),
        title: Text(widget.product.title),
        subtitle: Text('Rs. ${widget.product.price.toString()}'),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
