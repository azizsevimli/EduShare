import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/core/constants/constants.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.vanilla,
          foregroundColor: AppColors.orange,
          title: Text('Product Detail Page', style: TextStyle(color: AppColors.orange)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Product ID: ${widget.productId}'),
            ],
          ),
        ),
      ),
    );
  }
}
