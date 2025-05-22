import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/my_materials_list.dart';
import '../../models/material_model.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../core/widgets/user_info.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/custom_circular_indicator.dart';

class UserDetailPage extends StatefulWidget {
  final String userId;
  const UserDetailPage({super.key, required this.userId});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final UserServices _userService = UserServices();
  late Future<UserModel?> userFuture;
  late Future<List<MaterialModel>> userMaterialsFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    userFuture = _userService.getUserData(uid: widget.userId);
    userMaterialsFuture = _userService.getUserMaterials(uid: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Kullanıcı Detayı",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildUserInfoArea(),
              const Divider(
                color: AppColors.xanthous,
                height: 30.0,
                thickness: 2.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildButton(
                      index: 0,
                      text: 'Satışta Olanlar',
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Expanded(
                    flex: 1,
                    child: _buildButton(
                      index: 1,
                      text: 'Satılanlar',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              MyMaterialsList(
                future: userMaterialsFuture,
                index: _selectedIndex,
                type: "user",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInfoArea() {
    return FutureBuilder<UserModel?>(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomCircularIndicator();
        }
        if (snapshot.hasError) {
          return Text("Hata: ${snapshot.error}");
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text("Kullanıcı verisi bulunamadı.");
        }
        final UserModel user = snapshot.data!;
        return UserInfoCard(user: user);
      },
    );
  }

  Widget _buildButton({
    required int index,
    required String text,
  }) {
    final bool isSelected = _selectedIndex == index;

    return isSelected
        ? CustomElevatedButton(
            onPressed: () {},
            text: text,
            bgColor: AppColors.tiffany,
          )
        : CustomOutlinedButton(
            onPressed: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            text: text,
            fgColor: AppColors.tiffany,
          );
  }
}
