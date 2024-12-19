import 'package:flutter/material.dart';
import 'package:edushare/config/theme.dart';
import 'package:edushare/widgets/product_card.dart';
import 'package:edushare/widgets/outlined_button.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  void pressedBtn() {
    debugPrint('Basıldı');
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                  /*----Filter-Button----*/
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
                  /*----Sort-Button----*/
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
              Text(
                '3 sonuç listelendi',
                style: AppTxtStyle.body.copyWith(
                  color: AppColor.darkGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              /*----Product-List----*/
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ProductCardView(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  );
                },
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
      style: AppTxtStyle.body,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        hintText: 'Ara',
        hintStyle: AppTxtStyle.body.copyWith(
          color: AppColor.darkBrown,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 20,
          color: AppColor.darkBrown,
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
