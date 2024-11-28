import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/providers/ProductProvider.dart';
import 'package:store/src/utils/CategoryFilter.dart';
import 'package:store/src/utils/ShowProductModal.dart';
import 'package:store/src/widgets/FilterTray.dart';
import 'package:store/src/widgets/HomePageList.dart';
import 'package:store/src/widgets/TopProductItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random random = Random();
  List<Product> topProducts = [];
  HashMap<int, String> categoryTypes = HashMap();
  bool isDataInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      productProvider.fetchProducts().then((_) {
        if (mounted) {
          _initializeData(productProvider.products);
        }
      });
    });
  }

  void _initializeData(List<Product> products) {
    if (products.isNotEmpty) {
      // this is broken for now
      // categoryTypes = filterCategory(products);

      topProducts = List.generate(
        5,
        (_) => products[random.nextInt(products.length)],
      );

      setState(() {
        isDataInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: productProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : !isDataInitialized
              ? const Center(
                  child: Text(
                    'No data found',
                    style: TextStyle(fontSize: 20, color: AppColors.black),
                  ),
                )
              : SafeArea(
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
                          child: Text(
                            'Top Products',
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 250,
                          child: TopProductItem(topProducts: topProducts),
                        ),
                        const SizedBox(height: 5),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 12),
                        //   child: Text(
                        //     'Shop by category',
                        //     style: TextStyle(
                        //       fontSize: 25,
                        //       color: AppColors.black,
                        //       fontWeight: FontWeight.w800,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 5),
                        // FilterTray(
                        //   categoryIds: categoryTypes.keys.toList(),
                        //   categoryNames: categoryTypes.values.toList(),
                        // ),
                        // const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'All Products',
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        HomePageList(
                          items: productProvider.products,
                          showProductModal: showProductModal,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}