import 'package:edushare/widgets/outlined_button.dart';
import 'package:edushare/widgets/product_card.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  void pressedBtn() {
    debugPrint('Basıldı');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*----SearchBar----*/
              SizedBox(
                height: 40,
                child: searchBar(context),
              ),
              const SizedBox(height: 10),
              /*----Buttons----*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*----Btn1----*/
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: OutlinedBtn(
                        onPressed: pressedBtn,
                        txt: 'Filtrele',
                        icon: Icons.filter_list_rounded,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  /*----Btn2----*/
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: OutlinedBtn(
                        onPressed: pressedBtn,
                        txt: 'Sırala',
                        icon: Icons.sort_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('3 sonuç listelendi'),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ProductCardView(),
                      SizedBox(height: 10),
                      ProductCardView(),
                    ],
                  ),
                  Column(
                    children: [
                      ProductCardView(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*----Search-Bar----*/
  TextField searchBar(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        labelText: 'Ara',
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 20,
          color: Colors.black,
        ),
        enabledBorder: _searchBarBorder(context),
        focusedBorder: _searchBarBorder(context),
      ),
    );
  }

  /*----Search-Bar-Border----*/
  OutlineInputBorder _searchBarBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
      ),
    );
  }
}
