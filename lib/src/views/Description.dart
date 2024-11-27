import 'package:flutter/material.dart';
import 'package:store/src/constants/AppColors.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.product.title, style: TextStyle(color: AppColors.black, fontSize: 14),),
          Text(widget.product.title, style: TextStyle(color: AppColors.black, fontSize: 14),)
        ],
      ),
    );
  }
}