import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/constants/DefaultImage.dart';
import 'package:store/src/models/Product.dart';
import 'package:store/src/services/APIService.dart';
import 'package:store/src/utils/ProductConverter.dart';
import 'package:store/src/widgets/ModalSheet.dart';
import 'package:store/src/widgets/ProductListItem.dart';

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ProductModalSheet(product: product);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Store Room',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final Product product = ProductDataConversion(items[index]);
                return ProductListItem(product: product, tapProvider: _showProductDetailsModal, parentContext: context);
              },
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
