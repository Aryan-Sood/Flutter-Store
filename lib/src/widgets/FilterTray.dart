import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';

class FilterTray extends StatelessWidget {

  final List<int> categoryIds;
  final List<String> categoryNames;
  const FilterTray({super.key, required this.categoryIds, required this.categoryNames});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryIds.length,
        itemBuilder: (context, index){
          return Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Chip(
            label: Text(categoryNames[index],
            style: const TextStyle(color: AppColors.black),
            ),
            backgroundColor: AppColors.white,
            labelStyle: const TextStyle(color: AppColors.white),
            ),
          );
        }),
    );
  }
}