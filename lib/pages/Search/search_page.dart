import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/custom_circular_indicator.dart';
import '../../core/widgets/material_card.dart';
import '../../models/material_model.dart';
import '../../services/algolia_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final AlgoliaService _algoliaService = AlgoliaService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<MaterialModel> _results = [];
  bool _isLoading = false;

  void _onSearch(String query) async {
    if (query.trim().length < 3) {
      setState(() {
        _results = [];
      });
      return;
    }

    setState(() => _isLoading = true);
    _results = await _algoliaService.searchMaterials(query: query);
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearchBar(),
          const SizedBox(height: 20),
          if (_isLoading) const CustomCircularIndicator(),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final material = _results[index];
                  return MaterialCard(material: material);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _onSearch,
      decoration: InputDecoration(
        hintText: 'Arama için en az 3 karakter girin',
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: AppColors.tiffany,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: AppColors.tiffany,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
