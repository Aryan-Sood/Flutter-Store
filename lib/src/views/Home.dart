import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/services/APIService.dart';
import 'package:store/src/utils/CategoryFilter.dart';
import 'package:store/src/utils/ProductConverter.dart';
import 'package:store/src/widgets/FilterTray.dart';
import 'package:store/src/widgets/HomePageList.dart';
import 'package:store/src/utils/ShowProductModal.dart';
import 'package:store/src/widgets/TopProductItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Random random = Random();

  late Future<List<dynamic>> data;
  late HashMap<int, String> categoryTypes;
  List<int> categoryIds = [];
  List<String> categoryNames = [];
  List<Product> topProducts = [];

  @override
  void initState() {
    super.initState();
    data = APIService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading data',
                style: TextStyle(fontSize: 20, color: AppColors.black),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final items = snapshot.data!;

            categoryTypes = filterCategory(items);
            categoryTypes.forEach((key, value) {
              categoryIds.add(key);
              categoryNames.add(value);
            });

            for (int i=0;i<5;i++){
              int rand = random.nextInt(items.length-1);
              final Product product = ProductDataConversion(items[rand]);
              topProducts.add(product);
            }
            return SafeArea(
              top: true,
              bottom: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    const SizedBox(height: 10),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Top Products',
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.black,
                                fontWeight: FontWeight.w800))),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 250,
                      child: TopProductItem(topProducts: topProducts)
                    ),
                    
              
                    // const SizedBox(height: 15),
                    // const Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 12),
                    //     child: Text('Shop by category',
                    //         style: TextStyle(
                    //             fontSize: 25,
                    //             color: AppColors.black,
                    //             fontWeight: FontWeight.w800))),
                    // const SizedBox(height: 5),
                    // FilterTray(
                    //     categoryIds: categoryIds, categoryNames: categoryNames),
              
                    const SizedBox(height: 15),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('All Products',
                            style: TextStyle(
                                fontSize: 25,
                                color: AppColors.black,
                                fontWeight: FontWeight.w800))),
                  HomePageList(items: items, showProductModal: showProductModal)
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No data found',
                style: TextStyle(fontSize: 20, color: AppColors.black),
              ),
            );
          }
        },
      ),
    );
  }
}
