import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/sneaker_model.dart';
import 'package:flutter_ecommerce_app/providers/product_provider.dart';
import 'package:flutter_ecommerce_app/view/ui/product_screen.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter_ecommerce_app/view/widgets/category_btn.dart';
import 'package:flutter_ecommerce_app/view/widgets/custom_spacer.dart';
import 'package:flutter_ecommerce_app/view/widgets/staggered_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/nike.png',
    'assets/images/ndure.webp',
    'assets/images/gucci.png',
  ];

  double value = 100;

  @override
  Widget build(BuildContext context) {
    //product provider
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.getMale();
    productProvider.getFemale();
    productProvider.getKids();
    var height = MediaQuery.of(context).size.height * 1;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: whiteColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesomeIcons.sliders,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.white,
                      dividerColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, Colors.white, FontWeight.bold),
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
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.175, left: 16, right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TabBarView(controller: _tabController, children: [
                  //////////////////////////TAB 1////////////////////////////////////////////////////
                  FutureBuilder<List<SneakerModel>>(
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
                          return MasonryGridView.builder(
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 16,
                              itemCount: male!.length,
                              scrollDirection: Axis.vertical,

                              //Item Builder
                              itemBuilder: (context, index) {
                                final shoe = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    productProvider.shoeSizes = shoe.sizes;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                id: shoe.id,
                                                category: shoe.category)));
                                  },
                                  child: StaggeredTile(
                                      imageUrl: shoe.imageUrl[0],
                                      name: shoe.name,
                                      price: shoe.price),
                                );
                              });
                        }
                      }),
                  //////////////////////  TAB 2   /////////////////////////////////////////////////////
                  FutureBuilder<List<SneakerModel>>(
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
                          return MasonryGridView.builder(
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 16,
                              itemCount: female!.length,
                              scrollDirection: Axis.vertical,

                              //Item Builder
                              itemBuilder: (context, index) {
                                final shoe = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    productProvider.shoeSizes = shoe.sizes;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                id: shoe.id,
                                                category: shoe.category)));
                                  },
                                  child: StaggeredTile(
                                      imageUrl: shoe.imageUrl[0],
                                      name: shoe.name,
                                      price: shoe.price),
                                );
                              });
                        }
                      }),
                  /////////////////////////////////////////////TAB 3  /////////////////////////////////
                  FutureBuilder<List<SneakerModel>>(
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
                          return MasonryGridView.builder(
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 16,
                              itemCount: kids!.length,
                              scrollDirection: Axis.vertical,

                              //Item Builder
                              itemBuilder: (context, index) {
                                final shoe = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    productProvider.shoeSizes = shoe.sizes;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                id: shoe.id,
                                                category: shoe.category)));
                                  },
                                  child: StaggeredTile(
                                      imageUrl: shoe.imageUrl[0],
                                      name: shoe.name,
                                      price: shoe.price),
                                );
                              });
                        }
                      }),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////   FILTER    //////////////////////////////////////

  Future<dynamic> filter() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.86,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.71,
                    child: Column(
                      children: [
                        const CustomSpacer(),
                        Text(
                          'Filter',
                          style: appStyle(40, Colors.black, FontWeight.bold),
                        ),
                        const CustomSpacer(),
                        Text(
                          'Gender',
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            CategoryBtn(
                                label: 'Men',
                                buttonColor: Colors.black,
                                onPressed: () {}),
                            CategoryBtn(
                                label: 'Women',
                                buttonColor: Colors.black,
                                onPressed: () {}),
                            CategoryBtn(
                                label: 'Kids',
                                buttonColor: Colors.black,
                                onPressed: () {}),
                          ],
                        ),
                        const CustomSpacer(),
                        Text(
                          "Category",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CategoryBtn(
                                label: 'Shoes',
                                buttonColor: Colors.black,
                                onPressed: () {}),
                            CategoryBtn(
                                label: 'Apparrels',
                                buttonColor: Colors.black,
                                onPressed: () {}),
                            CategoryBtn(
                                label: 'Accessories',
                                buttonColor: Colors.black,
                                onPressed: () {}),
                          ],
                        ),
                        const CustomSpacer(),
                        Text('Price',
                            style: appStyle(20, Colors.black, FontWeight.bold)),
                        const CustomSpacer(),
                        Slider(
                          value: value,
                          min: 0,
                          max: 500,
                          divisions: 100,
                          label: value.round().toString(),
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey,
                          thumbColor: Colors.black,
                          onChanged: (double newValue) {
                            setState(() {
                              value = newValue;
                            });
                          },
                        ),
                        const CustomSpacer(),
                        Text(
                          'Brands',
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 90,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: brand.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.asset(
                                      brand[index],
                                      height: 70,
                                      width: 78,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
