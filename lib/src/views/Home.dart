import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/models/Category.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/services/APIService.dart';
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

  @override
  Widget build(BuildContext context) {
    // using this default URL for the items which have broken URLs
    const String defaultImageURl = 'https://i.imgur.com/0qQBkxX.jpg';

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Store Room',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final Category category = Category(
                                  id: items[index]['category']['id'],
                                  name: items[index]['category']['name'],
                                  image: items[index]['category']['image']);
                              final Product product = Product(
                                  id: items[index]['id'],
                                  title: items[index]['title'],
                                  price: items[index]['price'],
                                  description: items[index]['description'],
                                  images: items[index]['images'],
                                  category: category);
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.all(8),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage(product: product)));
                                  },
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: product.images[0][0] != 'h'
                                          ? defaultImageURl
                                          : product.images[0],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(strokeWidth: 1),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  title: Text(product.title),
                                  subtitle: Text(product.price.toString()),
                                  trailing:
                                      const Icon(Icons.arrow_forward_ios),
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
