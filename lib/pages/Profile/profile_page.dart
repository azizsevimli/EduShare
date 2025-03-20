import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/widgets/product_card.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../services/user_data_services.dart';
import '../../core/widgets/user_info.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserData ud = UserData();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late Future<UserModel?> userFuture;
  late Future<List<ProductModel>> productFuture;
  int _selectedIndex = 0;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    userFuture = ud.getUserData(uid: uid);
    productFuture = ud.getUserProducts(uid: uid);
  }

  Future<void> logoutBtn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (context.mounted) {
        ShowSnackBar.showSnackBar(context, 'Çıkış yapılırken hata oluştu: $e');
      }
    }
  }

  void goProfileEditPage() {
    context.push('/profile/edit', extra: user.toMap());
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<UserModel?>(
              future: userFuture,
              builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: width * 0.9,
                    height: 150,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Hata oluştu: ${snapshot.error}");
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Text("Kullanıcı verisi bulunamadı.");
                }

                user = snapshot.data!;

                return UserInfoCard(user: user);
              },
            ),
            CustomElevatedButton(
              text: 'Profili Düzenle',
              onPressed: goProfileEditPage,
              width: width * 0.9,
              textStyle: AppTextStyles.body2,
              icon: Icons.edit_outlined,
            ),
            const SizedBox(height: 20),
            Container(
              width: width,
              height: 50,
              color: AppColors.wine,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _selectedIndex = 0),
                    icon: const Icon(
                      Icons.format_list_bulleted,
                      color: AppColors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _selectedIndex = 1),
                    icon: const Icon(
                      Icons.checklist_outlined,
                      color: AppColors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _selectedIndex = 2),
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<ProductModel>>(
              future: productFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Veriler yüklenirken bir hata oluştu!"));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Henüz ürün yüklemediniz."));
                }

                List<ProductModel> products = snapshot.data!;
                List<ProductModel> soldProducts = [];
                List<ProductModel> unsoldProducts = [];

                for (var product in products) {
                  if (product.isSold) {
                    soldProducts.add(product);
                  }
                  else {
                    unsoldProducts.add(product);
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _selectedIndex == 0 ? unsoldProducts.length : soldProducts.length,
                    itemBuilder: (context, index) {
                      if (_selectedIndex == 0) {
                        return ProductCard(product: unsoldProducts[index]);
                      }else if (_selectedIndex == 1) {
                        return ProductCard(product: soldProducts[index]);
                      }

                      return ProductCard(product: products[index]);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 50.0),
            CustomElevatedButton(
              text: 'Çıkış Yap',
              onPressed: () => logoutBtn(context),
            ),
          ],
        ),
      ),
    );
  }
}
