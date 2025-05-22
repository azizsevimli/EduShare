import 'package:flutter/material.dart';
import '../../models/material_model.dart';
import '../../services/material_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MaterialServices _materialServices = MaterialServices();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<MaterialModel> _searchResults = [];
  bool isSearching = false;

  void _onSearchChanged(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => isSearching = true);
    final results = await _materialServices.searchMaterial(query: query);

    setState(() {
      _searchResults = results;
      isSearching = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _scrollController.dispose();
  }

  // TODO: Sonuçları düzgün bir şekilde listele
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            // Search bar
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(child: Text("Sonuç bulunamadı"))
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final material = _searchResults[index];
                      return ListTile(
                        title: Text(material.title),
                        subtitle: Text(material.description),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
