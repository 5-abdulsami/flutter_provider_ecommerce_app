import 'package:flutter_ecommerce_app/models/sneaker_model.dart';
import 'package:flutter_ecommerce_app/providers/product_provider.dart';
import 'package:flutter_ecommerce_app/view/ui/product_by_cat.dart';
import 'package:flutter_ecommerce_app/view/ui/product_screen.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/view/widgets/new_shoes_widget.dart';
import 'package:flutter_ecommerce_app/view/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getMale();
    productProvider.getKids();
    productProvider.getFemale();

    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        backgroundColor: const Color(0XFFE2E2E2),
        body: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: height * 0.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/top_image.png'),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, bottom: 25),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Athletic Shoes',
                        style: appStyleWithHeight(
                            42, Colors.white, FontWeight.bold, 1.5),
                      ),
                      Text(
                        'Collection',
                        style: appStyleWithHeight(
                            42, Colors.white, FontWeight.bold, 1.2),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.white,
                          dividerColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appStyle(24, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.5),
                          tabs: const [
                            Tab(
                              text: 'Men Shoes',
                            ),
                            Tab(
                              text: 'Women Shoes',
                            ),
                            Tab(
                              text: 'Kids Shoes',
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.295),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    ///////////////////////////////////////////////////Tab Bar 1////////////////////////////////////////////////////////////////////////////////////////
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.415,
                          child: FutureBuilder<List<SneakerModel>>(
                              future: productProvider.male,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final male = snapshot.data;
                                  return ListView.builder(
                                      itemCount: male!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final shoe = snapshot.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            productProvider.shoeSizes =
                                                shoe.sizes;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen(
                                                            id: shoe.id,
                                                            category: shoe
                                                                .category)));
                                          },
                                          child: ProductCard(
                                              price: shoe.price,
                                              category: shoe.category,
                                              id: shoe.id,
                                              name: shoe.name,
                                              image: shoe.imageUrl[0]),
                                        );
                                      });
                                }
                              }),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                              child: Row(
                                children: [
                                  Text(
                                    'Latest Shoes',
                                    style: appStyle(
                                        24, Colors.black, FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductByCat(
                                                          tabIndex: 0)));
                                        },
                                        child: Text(
                                          'Show All',
                                          style: appStyle(20, Colors.black,
                                              FontWeight.w500),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_right,
                                        size: 35,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.12,
                          child: FutureBuilder<List<SneakerModel>>(
                              future: productProvider.male,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final male = snapshot.data;
                                  return ListView.builder(
                                      itemCount: male!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final shoe = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: NewShoesWidget(
                                              imageUrl: shoe.imageUrl[1],
                                              width: width),
                                        );
                                      });
                                }
                              }),
                        ),
                      ],
                    ),
                    /////////////////////////////////////////Tab Bar 2 ////////////////////////////////////////////////////
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.425,
                          child: FutureBuilder<List<SneakerModel>>(
                              future: productProvider.female,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final female = snapshot.data;
                                  return ListView.builder(
                                      itemCount: female!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final shoe = snapshot.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            productProvider.shoeSizes =
                                                shoe.sizes;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen(
                                                            id: shoe.id,
                                                            category: shoe
                                                                .category)));
                                          },
                                          child: ProductCard(
                                              price: shoe.price,
                                              category: shoe.category,
                                              id: shoe.id,
                                              name: shoe.name,
                                              image: shoe.imageUrl[0]),
                                        );
                                      });
                                }
                              }),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 7, 12, 5),
                              child: Row(
                                children: [
                                  Text(
                                    'Latest Shoes',
                                    style: appStyle(
                                        24, Colors.black, FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProductByCat(
                                                      tabIndex: 1)));
                                    },
                                    child: Text(
                                      'Show All',
                                      style: appStyle(
                                          20, Colors.black, FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.003,
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    size: 35,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.12,
                          child: FutureBuilder<List<SneakerModel>>(
                              future: productProvider.female,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final female = snapshot.data;
                                  return ListView.builder(
                                      itemCount: female!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final shoe = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: NewShoesWidget(
                                              imageUrl: shoe.imageUrl[1],
                                              width: width),
                                        );
                                      });
                                }
                              }),
                        ),
                      ],
                    ),
                    //////////////////////////////////////////Tab Bar 3 //////////////////////////////////////////////////////////////
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.415,
                          child: FutureBuilder<List<SneakerModel>>(
                              future: productProvider.kids,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final kids = snapshot.data;
                                  return ListView.builder(
                                      itemCount: kids!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final shoe = snapshot.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            productProvider.shoeSizes =
                                                shoe.sizes;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen(
                                                            id: shoe.id,
                                                            category: shoe
                                                                .category)));
                                          },
                                          child: ProductCard(
                                              price: shoe.price,
                                              category: shoe.category,
                                              id: shoe.id,
                                              name: shoe.name,
                                              image: shoe.imageUrl[0]),
                                        );
                                      });
                                }
                              }),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                              child: Row(
                                children: [
                                  Text(
                                    'Latest Shoes',
                                    style: appStyle(
                                        24, Colors.black, FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProductByCat(
                                                    tabIndex: 2,
                                                  )));
                                    },
                                    child: Text(
                                      'Show All',
                                      style: appStyle(
                                          20, Colors.black, FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.003,
                                  ),
                                  const Icon(
                                    Icons.arrow_right,
                                    size: 35,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.12,
                          child: FutureBuilder<List<SneakerModel>>(
                              future: productProvider.kids,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  final kids = snapshot.data;
                                  return ListView.builder(
                                      itemCount: kids!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final shoe = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: NewShoesWidget(
                                              imageUrl: shoe.imageUrl[1],
                                              width: width),
                                        );
                                      });
                                }
                              }),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
