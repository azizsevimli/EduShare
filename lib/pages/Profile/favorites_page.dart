import 'package:flutter/material.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../models/material_model.dart';
import '../../services/favorite_service.dart';
import '../../services/material_service.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/material_card.dart';
import '../../core/widgets/custom_button.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteService _favoriteService = FavoriteService();
  final MaterialServices _materialService = MaterialServices();

  late Future<List<MaterialModel>> _favoritesFuture;

  Future<List<MaterialModel>> _getFavoriteMaterials() async {
    final favoriteIds = await _favoriteService.getFavoriteMaterials();
    final materials = await Future.wait(
      favoriteIds.map(
        (id) => _materialService.getMaterialById(id: id),
      ),
    );
    return materials.whereType<MaterialModel>().toList();
  }

  Future<void> _clearFavorites() async {
    await _favoriteService.clearFavorites();
    setState(() {
      _favoritesFuture = Future.value([]);
    });
  }

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _getFavoriteMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Favorilerim',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<MaterialModel>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CustomCircularIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Bir hata oluştu: ${snapshot.error}'),
              );
            }

            final materials = snapshot.data ?? [];

            if (materials.isEmpty) {
              return const Center(
                child: Text('Henüz favori materyaliniz yok.'),
              );
            }

            return _buildPageContent(materials: materials);
          },
        ),
      ),
    );
  }

  SingleChildScrollView _buildPageContent({
    required List<MaterialModel> materials,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildClearButton(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: materials.length,
            itemBuilder: (context, index) {
              return MaterialCard(material: materials[index]);
            },
          ),
        ],
      ),
    );
  }

  Row _buildClearButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomTextButton(
          text: 'Tümünü temizle',
          onPressed: _clearFavorites,
        ),
      ],
    );
  }
}
