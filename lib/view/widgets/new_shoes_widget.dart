import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';

class NewShoesWidget extends StatelessWidget {
  const NewShoesWidget({
    super.key,
    required this.imageUrl,
    required this.width,
  });

  final String imageUrl;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: whiteColor,
              spreadRadius: 1,
              blurRadius: 0.8,
              offset: Offset(0, 1)),
        ],
      ),
      width: width * 0.28,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
