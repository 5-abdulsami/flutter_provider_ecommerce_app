import 'package:flutter_ecommerce_app/providers/mainscreen_provider.dart';
import 'package:flutter_ecommerce_app/view/ui/cart_screen.dart';
import 'package:flutter_ecommerce_app/view/ui/favourites_screen.dart';
import 'package:flutter_ecommerce_app/view/ui/home_screen.dart';
import 'package:flutter_ecommerce_app/view/ui/profile_screen.dart';
import 'package:flutter_ecommerce_app/view/ui/search_screen.dart';
import 'package:flutter_ecommerce_app/view/widgets/bottm_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    const HomeScreen(),
    const SearchScreen(),
    const FavouritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainscreenProvider>(
        builder: (context, mainScreenProvider, child) {
      return Scaffold(
        backgroundColor: const Color(0XFFE2E2E2),
        body: pageList[mainScreenProvider.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
