import 'package:edushare/core/widgets/similar_materials_area.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/widgets/material_image_area.dart';
import '../../core/widgets/material_info_area.dart';
import '../../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final FirebaseFirestore ffs = FirebaseFirestore.instance;
  late ProductModel product;

  Future<ProductModel?> getProductById() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await ffs
        .collection('products')
        .where('id', isEqualTo: widget.productId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return ProductModel.fromMap(querySnapshot.docs.first.data());
    } else {
      debugPrint("Ürün bulunamadı");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getProductById();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<ProductModel?>(
          future: getProductById(),
          builder:
              (BuildContext context, AsyncSnapshot<ProductModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("Hata oluştu: ${snapshot.error}");
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("Ürün bulunamadı");
            }
            product = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialImageArea(imageUrls: product.imageUrls, id: product.id),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialInfoArea(product: product),
                      const SizedBox(height: 20),
                      SimilarMaterialsArea(department: product.department),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
