import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/models/Product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:store/src/constants/DefaultImage.dart';

class ProductModalSheet extends StatefulWidget {
  final Product product;
  const ProductModalSheet({super.key, required this.product});

  @override
  State<ProductModalSheet> createState() => _ProductModalSheetState();
}

class _ProductModalSheetState extends State<ProductModalSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollContainer) {
        return SingleChildScrollView(
          controller: scrollContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CarouselSlider.builder(
                    itemCount: widget.product.images.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.images[index],
                            fit: BoxFit.cover,
                            height: 400,
                            width: double.infinity,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator.adaptive()),
                            errorWidget: (context, url, error) =>
                                CachedNetworkImage(
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
                        autoPlayInterval: const Duration(milliseconds: 2000))),
                const SizedBox(height: 40),
                Text(widget.product.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(widget.product.description,
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.black)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Category - ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    Text(widget.product.category.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.category.image,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) => CachedNetworkImage(
                      imageUrl: DefaultImage.DefaultImageURL,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      foregroundColor: AppColors.black, // Text and icon color
                      side: const BorderSide(
                        color: AppColors.black, // Border color
                        width: 1, // Border thickness
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      elevation: 2, // Button shadow
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart')),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.shopping_cart),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
