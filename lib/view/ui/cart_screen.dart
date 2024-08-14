import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ecommerce_app/providers/cart_provider.dart';
import 'package:flutter_ecommerce_app/view/ui/main_screen.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/view/widgets/checkout_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: const Color(0XFFE2E2E2),
      body: cartProvider.cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.grey,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'The Cart is Empty',
                    style: appStyle(35, Colors.grey, FontWeight.w500),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'My Cart',
                        style: appStyle(36, Colors.black, FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.builder(
                            itemCount: cartProvider.cart.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final data = cartProvider.cart[index];
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Slidable(
                                      key: const ValueKey(0),
                                      endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                                flex: 1,
                                                backgroundColor: Colors.black,
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                                label: 'Delete',
                                                onPressed: (context) {
                                                  cartProvider
                                                      .deleteCart(data['key']);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainScreen()));
                                                }),
                                          ]),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 5,
                                              blurRadius: 0.3,
                                              offset: const Offset(0, 1),
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            data['imageUrl'],
                                                        height: 70,
                                                        width: 70,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: -2,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          cartProvider
                                                              .deleteCart(
                                                                  data['key']);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MainScreen()));
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, left: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        style: appStyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      Text(
                                                        data['category'],
                                                        style: appStyle(
                                                            14,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '\$${data['price']}',
                                                            style: appStyle(
                                                                18,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          const SizedBox(
                                                              width: 40),
                                                          Text(
                                                            'Size',
                                                            style: appStyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            '${data['sizes']}',
                                                            style: appStyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            cartProvider
                                                                .decrement();
                                                            if (cartProvider
                                                                    .counter ==
                                                                0) {
                                                              cartProvider
                                                                  .deleteCart(
                                                                      data[
                                                                          'key']);
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MainScreen()));
                                                            }
                                                          },
                                                          child: const Icon(
                                                            Icons.minimize,
                                                            size: 20,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Text(
                                                          cartProvider.counter
                                                              .toString(),
                                                          style: appStyle(
                                                              12,
                                                              Colors.black,
                                                              FontWeight.w600),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            cartProvider
                                                                .increment();
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            size: 20,
                                                            color: blackColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutButton(label: 'Proceed to Checkout'),
                  ),
                ],
              ),
            ),
    );
  }
}
