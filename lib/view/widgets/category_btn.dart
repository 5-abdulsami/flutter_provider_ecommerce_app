import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key,
      required this.label,
      required this.buttonColor,
      required this.onPressed});
  final void Function()? onPressed;
  final Color buttonColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonColor,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            label,
            style: appStyle(16, buttonColor, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
