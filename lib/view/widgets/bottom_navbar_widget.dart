import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter/material.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key, this.icon, this.onTap});

  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          icon,
          color: whiteColor,
        ),
      ),
    );
  }
}
