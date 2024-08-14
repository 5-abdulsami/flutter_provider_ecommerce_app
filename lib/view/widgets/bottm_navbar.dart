import 'package:flutter_ecommerce_app/providers/mainscreen_provider.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter_ecommerce_app/view/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainscreenProvider>(
        builder: (context, mainScreenProvider, child) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(7),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: blackColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomNavbarWidget(
                icon: mainScreenProvider.pageIndex == 0
                    ? Icons.home
                    : Icons.home_outlined,
                onTap: () {
                  mainScreenProvider.pageIndex = 0;
                },
              ),
              BottomNavbarWidget(
                icon: mainScreenProvider.pageIndex == 1
                    ? Icons.search
                    : Icons.search,
                onTap: () {
                  mainScreenProvider.pageIndex = 1;
                },
              ),
              BottomNavbarWidget(
                icon: mainScreenProvider.pageIndex == 2
                    ? Icons.favorite
                    : Icons.favorite_border,
                onTap: () {
                  mainScreenProvider.pageIndex = 2;
                },
              ),
              BottomNavbarWidget(
                icon: mainScreenProvider.pageIndex == 3
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                onTap: () {
                  mainScreenProvider.pageIndex = 3;
                },
              ),
              BottomNavbarWidget(
                icon: mainScreenProvider.pageIndex == 4
                    ? Icons.person
                    : Icons.person_2_outlined,
                onTap: () {
                  mainScreenProvider.pageIndex = 4;
                },
              ),
            ],
          ),
        ),
      ));
    });
  }
}
