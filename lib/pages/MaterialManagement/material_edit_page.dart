import 'package:flutter/material.dart';

class MaterialEditPage extends StatefulWidget {
  final String materialId;
  const MaterialEditPage({
    super.key,
    required this.materialId,
  });

  @override
  State<MaterialEditPage> createState() => _MaterialEditPageState();
}

// TODO: Materyal düzenleme sayfası oluşturulacak.
class _MaterialEditPageState extends State<MaterialEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.materialId,
        ),
      ),
    );
  }
}
