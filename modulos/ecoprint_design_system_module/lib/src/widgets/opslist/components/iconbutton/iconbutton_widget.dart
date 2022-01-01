import 'package:flutter/material.dart';

class IconbuttonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function()? onPressed;
  final bool? isImp;

  const IconbuttonWidget({
    Key? key,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.isImp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 15,
        color: color,
      ),
      splashRadius: 10,
      padding: const EdgeInsets.all(4),
      onPressed: isImp! ? onPressed : null,
    );
  }
}
