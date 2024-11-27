import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/constants/DefaultImage.dart';
import 'package:store/src/constants/FontStyles.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/services/APIService.dart';
import 'package:store/src/utils/ProductConverter.dart';
import 'package:store/src/views/Description.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = APIService.fetchData();
  }

  void _showProductDetailsModal(BuildContext context, Product product) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollContainer) {
              return SingleChildScrollView(
                controller: scrollContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          itemCount: product.images.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CachedNetworkImage(
                                imageUrl: product.images[index],
                                fit: BoxFit.cover,
                                height: 400,
                                width: double.infinity,
                                placeholder: (context, url) => const Center(
                                  child: Text(
                                    'Loading',
                                    style: TextStyle(
                                        fontSize: 14, color: AppColors.black),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    CachedNetworkImage(
                                  imageUrl: Defaultimage.DefaultImageURL,
                                  fit: BoxFit.cover,
                                  height: 400,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              autoPlayInterval:
                                  const Duration(milliseconds: 2000))),
                      const SizedBox(height: 40),
                      Text(product.title,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black)),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(product.description,
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.black)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
          top: true,
          bottom: false,
          child: FutureBuilder<List<dynamic>>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              } else if (snapshot.hasError) {
                return const Text('Error loading data',
                    style: TextStyle(fontSize: 20, color: AppColors.black));
              } else if (snapshot.hasData) {
                final items = snapshot.data!;
                return SafeArea(
                  top: true,
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0,10,0,0),
                        child: Text(
                          'Store Room',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(5,0,5,0),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final Product product =
                                ProductDataConversion(items[index]);
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                onTap: () {
                                  _showProductDetailsModal(context, product);
                                },
                                contentPadding: const EdgeInsets.all(12),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: product.images[0],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                            strokeWidth: 1),
                                    errorWidget: (context, url, error) =>
                                        CachedNetworkImage(
                                            imageUrl:
                                                Defaultimage.DefaultImageURL),
                                  ),
                                ),
                                title: Text(product.title),
                                subtitle: Text(product.price.toString()),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('No data found',
                      style: TextStyle(fontSize: 20, color: AppColors.black)),
                );
              }
            },
          )),
    );
  }
}
