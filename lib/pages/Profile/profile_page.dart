import 'package:edushare/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/material_card.dart';
import '../../models/material_model.dart';
import '../../models/user_model.dart';
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
  final UserServices us = UserServices();
  late Future<UserModel?> userFuture;
  late Future<List<MaterialModel>> materialFuture;
  late Future<List<MaterialModel>> favoriteMaterialFuture;
  int _selectedIndex = 0;
  late UserModel user;
  List<MaterialModel> favoriteMaterials = [];
  bool isLoadingFavorites = true;

  @override
  void initState() {
    super.initState();
    userFuture = us.getUserData();
    materialFuture = us.getUserMaterials();
    favoriteMaterialFuture = us.getFavoriteMaterials();
    _loadFavoriteMaterials();
  }

  void _loadFavoriteMaterials() async {
    favoriteMaterials = await us.getFavoriteMaterials();
    setState(() {
      isLoadingFavorites = false;
    });
  }

  Future<void> logoutBtn(BuildContext context) async {
    us.logoutUser(
      onSuccess: () => context.go('/login'),
      onError: (e) => ShowSnackBar.showSnackBar(
          context, 'Çıkış yapılırken hata oluştu: $e'),
    );
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
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: width * 0.9,
                    height: 150,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Hata oluştu: ${snapshot.error}");
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("Kullanıcı verisi bulunamadı.");
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
            const SizedBox(height: 10),

            _selectedIndex != 2
                ? FutureBuilder<List<MaterialModel>>(
                    future: materialFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child:
                                Text("Veriler yüklenirken bir hata oluştu!"));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("Henüz ürün yüklemediniz."));
                      }

                      List<MaterialModel> materials = snapshot.data!;
                      List<MaterialModel> soldMaterials = [];
                      List<MaterialModel> unsoldMaterials = [];

                      for (var material in materials) {
                        if (material.isSold) {
                          soldMaterials.add(material);
                        } else {
                          unsoldMaterials.add(material);
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.65,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _selectedIndex == 0
                              ? unsoldMaterials.length
                              : soldMaterials.length,
                          itemBuilder: (context, index) {
                            if (_selectedIndex == 0) {
                              return MaterialCard(
                                  material: unsoldMaterials[index]);
                            } else {
                              return MaterialCard(
                                  material: soldMaterials[index]);
                            }
                          },
                        ),
                      );
                    },
                  )
                : FutureBuilder(
                    future: favoriteMaterialFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child:
                                Text("Veriler yüklenirken bir hata oluştu!"));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("Henüz favori ürününüz bulunmamaktadır."));
                      }

                      List<MaterialModel> materials = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.65,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: materials.length,
                          itemBuilder: (context, index) {
                            return MaterialCard(material: materials[index]);
                          },
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 50.0),
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
