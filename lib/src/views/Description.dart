import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/constants/DefaultImage.dart';
import 'package:store/src/constants/FontStyles.dart';
import 'package:store/src/models/Product.dart';

class DescriptionPage extends StatefulWidget {
  final Product product;

  const DescriptionPage({super.key, required this.product});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: widget.product.images.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CachedNetworkImage(
                      imageUrl: widget.product.images[index],
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: Text(
                          'Loading',
                          style:
                              TextStyle(fontSize: 14, color: AppColors.black),
                        ),
                      ),
                      errorWidget: (context, url, error) => CachedNetworkImage(
                          imageUrl: DefaultImage.DefaultImageURL),
                    ),
                  );
                },
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    autoPlayInterval: const Duration(seconds: 2)),
              ),
              const SizedBox(height: 50),
              Text(widget.product.title, style: Fontstyles.commonTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}
