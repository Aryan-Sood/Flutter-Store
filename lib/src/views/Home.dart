import 'dart:collection';

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
  late Future<List<dynamic>> data;
  late HashMap<int, String> categoryTypes;
  List<int> categoryIds = [];
  List<String> categoryNames = [];

  @override
  void initState() {
    super.initState();
    data = APIService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Store Room',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
            return SingleChildScrollView(
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
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryIds.length,
                        itemBuilder: (context, index) {
                          final Product product = ProductDataConversion(items[index]);
                          return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: TopProductItem(product: product));
                        },
                        separatorBuilder: (context, index) => const SizedBox(width: 5) ),
                  ),


                  const SizedBox(height: 15),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Shop by category',
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800))),
                  const SizedBox(height: 5),
                  FilterTray(
                      categoryIds: categoryIds, categoryNames: categoryNames),

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
