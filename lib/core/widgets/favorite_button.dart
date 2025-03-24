import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../../services/favorite_service.dart';

class FavoriteButton extends StatefulWidget {
  final String id;
  final double? size;
  final Color? favColor;
  final Color? unfavColor;

  const FavoriteButton({
    super.key,
    required this.id,
    this.size,
    this.favColor,
    this.unfavColor,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavoriteService _favoriteService = FavoriteService();
  bool isFavorite = false;

  void _checkIfFavorite() async {
    final bool result = await _favoriteService.isFavorite(widget.id);
    setState(() {
      isFavorite = result;
    });
  }

  void addFavorite() async {
    if (isFavorite) {
      await _favoriteService.removeFavoriteProduct(widget.id);
    } else {
      await _favoriteService.addFavoriteProduct(widget.id);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: addFavorite,
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite
              ? (widget.favColor ?? AppColors.orange)
              : (widget.unfavColor ?? AppColors.grey),
          size: widget.size ?? 28,
        ));
  }
}
