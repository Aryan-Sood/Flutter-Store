import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
import 'package:store/src/services/APIService.dart';
import 'package:store/src/widgets/HomePageList.dart';
import 'package:store/src/utils/ShowProductModal.dart';

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
            return HomePageList(
                items: items, showProductModal: showProductModal);
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
