import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/DefaultImage.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/utils/ShowProductModal.dart';

class TopProductItem extends StatelessWidget {
  final List<Product> topProducts;
  const TopProductItem({super.key, required this.topProducts});

  @override
  Widget build(BuildContext context) {

    return  CarouselSlider.builder(
      itemCount: topProducts.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () => showProductModal(context, topProducts[index]),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: topProducts[index].images[0],
                  fit: BoxFit.cover,
                  height: 400,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => CachedNetworkImage(
                    imageUrl: DefaultImage.DefaultImageURL,
                    fit: BoxFit.cover,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            autoPlayInterval: const Duration(milliseconds: 2000)
      ));
  }
}
