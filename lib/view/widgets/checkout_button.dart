import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Center(
            child: Text(
              label,
              style: appStyle(16, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
