import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/sneaker_model.dart';
import 'package:flutter_ecommerce_app/providers/cart_provider.dart';
import 'package:flutter_ecommerce_app/providers/favorites_provider.dart';
import 'package:flutter_ecommerce_app/providers/product_provider.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter_ecommerce_app/view/widgets/checkout_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //product provider
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.getShoes(widget.category, widget.id);
    //favorites provider
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: true);
    //cart provider
    final cartProvider = Provider.of<CartProvider>(context);
    favoritesProvider.getFavorites();

    return Scaffold(
        body: FutureBuilder<SneakerModel>(
            future: productProvider.sneaker,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                final sneaker = snapshot.data;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                productProvider.shoeSizes.clear();
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (newPage) {
                                    productProvider.activePage = newPage;
                                  },
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          right: 20,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (favoritesProvider.ids
                                                  .contains(widget.id)) {
                                                // If it's already a favorite, remove it
                                                final keyToRemove =
                                                    favoritesProvider.favorites
                                                        .firstWhere((fav) =>
                                                            fav['id'] ==
                                                            widget.id)['key'];

                                                if (keyToRemove != null) {
                                                  favoritesProvider
                                                      .deleteFav(keyToRemove);
                                                  favoritesProvider
                                                      .getFavorites(); // Refresh favorites list
                                                }
                                              } else {
                                                // If it's not a favorite, add it
                                                favoritesProvider.createFav({
                                                  "id": widget.id,
                                                  "name": sneaker.name,
                                                  "category": sneaker.category,
                                                  "price": sneaker.price,
                                                  "imageUrl": sneaker.imageUrl
                                                }).then((_) {
                                                  favoritesProvider
                                                      .getFavorites(); // Refresh favorites list after adding
                                                });
                                              }
                                            },
                                            child: favoritesProvider.ids
                                                    .contains(widget.id)
                                                ? const Icon(
                                                    Icons.favorite,
                                                    color: Colors.black,
                                                  )
                                                : const Icon(
                                                    Icons.favorite_outline,
                                                    color: Colors.grey,
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List<Widget>.generate(
                                                  sneaker.imageUrl.length,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4),
                                                        child: CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              productProvider
                                                                          .activePage !=
                                                                      index
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      )),
                                            )),
                                      ],
                                    );
                                  }),
                            ),
                            Positioned(
                                bottom: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.625,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appStyle(35, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appStyle(18, Colors.grey,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 23,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  size: 25,
                                                  color: Colors.black,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appStyle(
                                                    28,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Colors',
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Select Sizes",
                                                    style: appStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'View Size Guide',
                                                    style: appStyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 35,
                                                child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: productProvider
                                                        .shoeSizes.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final sizes =
                                                          productProvider
                                                              .shoeSizes[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: ChoiceChip(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60),
                                                              side: const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1,
                                                                  style: BorderStyle
                                                                      .solid)),
                                                          disabledColor:
                                                              Colors.white,
                                                          label: Text(
                                                            sizes['size'],
                                                            style: appStyle(
                                                                14,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          selected: sizes[
                                                              "isSelected"],
                                                          onSelected:
                                                              (newState) {
                                                            if (productProvider
                                                                .sizes
                                                                .contains(sizes[
                                                                    'size'])) {
                                                              productProvider
                                                                  .sizes
                                                                  .remove(sizes[
                                                                      'size']);
                                                            } else {
                                                              productProvider
                                                                  .sizes
                                                                  .add(sizes[
                                                                      'size']);
                                                            }
                                                            productProvider
                                                                .toggleStatus(
                                                                    index);
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                sneaker.title,
                                                style: appStyle(
                                                    24,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              sneaker.description,
                                              textAlign: TextAlign.justify,
                                              maxLines: 4,
                                              style: appStyle(14, Colors.black,
                                                  FontWeight.normal),
                                            ),
                                          ),
                                          const Spacer(),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: CheckoutButton(
                                                label: 'Add to Cart',
                                                onTap: () {
                                                  cartProvider.createCart({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "sizes":
                                                        productProvider.sizes,
                                                    "category":
                                                        sneaker.category,
                                                    "imageUrl":
                                                        sneaker.imageUrl[0],
                                                    "price": sneaker.price,
                                                    "qty": 1
                                                  });
                                                  productProvider.sizes.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
