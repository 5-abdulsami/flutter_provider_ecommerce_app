import 'package:flutter_ecommerce_app/providers/cart_provider.dart';
import 'package:flutter_ecommerce_app/providers/favorites_provider.dart';
import 'package:flutter_ecommerce_app/providers/mainscreen_provider.dart';
import 'package:flutter_ecommerce_app/providers/product_provider.dart';
import 'package:flutter_ecommerce_app/view/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MainscreenProvider(),
    ),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
    ),
    ChangeNotifierProvider(create: (context) => CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ecommerce App Provider',
          theme: ThemeData(),
          home: MainScreen(),
        );
      },
    );
  }
}
