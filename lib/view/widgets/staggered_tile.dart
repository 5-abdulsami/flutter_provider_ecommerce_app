import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';

class StaggeredTile extends StatefulWidget {
  const StaggeredTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});

  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggeredTile> createState() => _StaggeredTileState();
}

class _StaggeredTileState extends State<StaggeredTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
              height: height * 0.2,
            ),
            Container(
              height: 88,
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appStyleWithHeight(
                        20, blackColor, FontWeight.w700, 1.1),
                  ),
                  Text(
                    "\$${widget.price}",
                    style: appStyleWithHeight(
                        20, blackColor, FontWeight.w500, 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
