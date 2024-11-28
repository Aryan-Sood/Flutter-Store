import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/DefaultImage.dart';
import 'package:store/src/models/Product.dart';

class CarouselSliderView extends StatelessWidget {
  final Product product;

  const CarouselSliderView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: product.images.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: product.images[index],
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
          );
        },
        options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            autoPlayInterval: const Duration(milliseconds: 2000)));
  }
}
