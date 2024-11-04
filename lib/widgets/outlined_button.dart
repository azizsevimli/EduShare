import 'package:flutter/material.dart';

class OutlinedBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String txt;
  final IconData icon;

  const OutlinedBtn({
    super.key,
    required this.onPressed,
    required this.txt,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        //color: Colors.white,
        size: 20,
      ),
      label: Text(
        txt,
        style: const TextStyle(
          //color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
      style: const ButtonStyle(
        side: WidgetStatePropertyAll(
          BorderSide(
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
