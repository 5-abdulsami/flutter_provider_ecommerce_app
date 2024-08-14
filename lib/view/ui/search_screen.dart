import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SearchPage',
          style: appStyle(40, blackColor, FontWeight.bold),
        ),
      ),
    );
  }
}
