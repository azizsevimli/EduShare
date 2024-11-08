import 'package:edushare/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:edushare/config/theme/theme.dart';
import 'package:edushare/widgets/product_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Gösterilecek ürünlerin listesi
  List<String> displayedItems = [];

  // İkon tıklamalarına göre listeyi güncelleyen yöntem
  void updateList(int index) {
    setState(() {
      if (index == 0) {
        displayedItems =
            List.generate(10, (i) => 'Item $i'); // Örneğin birinci ikon için
      } else if (index == 1) {
        displayedItems = List.generate(3, (i) => 'Checklist $i');
      } else if (index == 2) {
        displayedItems = List.generate(5, (i) => 'Favorite $i');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      /*----Profile-Image----*/
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/panda_512x512.png'),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*----User-Name----*/
                          Text(
                            'Kullanıcı Adı',
                            style: AppTxtStyle.h2.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              /*----University----*/
                              const Icon(
                                Icons.apartment_rounded,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Üniversite',
                                style: AppTxtStyle.body.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              /*----Department----*/
                              const Icon(
                                Icons.school_outlined,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Bölüm',
                                style: AppTxtStyle.body.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  /*----Profile-Edit-Button----*/
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedBtn(
                          onPressed: () {
                            debugPrint('Profil Düzenle');
                          },
                          txt: 'Profili Düzenle',
                          icon: Icons.edit,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.05,
              decoration: const BoxDecoration(
                color: AppColor.brown,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.format_list_bulleted_rounded,
                      color: AppColor.white,
                    ),
                    onPressed: () => updateList(0),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.checklist_rounded,
                      color: AppColor.white,
                    ),
                    onPressed: () => updateList(1),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: AppColor.white,
                    ),
                    onPressed: () => updateList(2),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedItems.length,
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
            ),
          ],
        ),
      ),
    );
  }
}
