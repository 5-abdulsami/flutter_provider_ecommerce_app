import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/providers/favorites_provider.dart';
import 'package:flutter_ecommerce_app/view/ui/favourites_screen.dart';
import 'package:flutter_ecommerce_app/view/widgets/app_style.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
    final favoriteProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    favoriteProvider.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoritesProvider>(context, listen: true);

    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    bool selected = false;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width * 0.6,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Container(
                      height: height * 0.23,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.image))),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: () {
                          if (favoriteProvider.ids.contains(widget.id)) {
                            // If it's already a favorite, remove it
                            final keyToRemove = favoriteProvider.favorites
                                .firstWhere(
                                    (fav) => fav['id'] == widget.id)['key'];

                            if (keyToRemove != null) {
                              favoriteProvider.deleteFav(keyToRemove);
                              favoriteProvider
                                  .getFavorites(); // Refresh favorites list
                            }
                          } else {
                            // If it's not a favorite, add it
                            favoriteProvider.createFav({
                              "id": widget.id,
                              "name": widget.name,
                              "category": widget.category,
                              "price": widget.price,
                              "imageUrl": widget.image
                            }).then((_) {
                              favoriteProvider
                                  .getFavorites(); // Refresh favorites list after adding
                            });
                          }
                        },
                        child: favoriteProvider.ids.contains(widget.id)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.black,
                              )
                            : const Icon(Icons.favorite_outline),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyleWithHeight(
                          30, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appStyleWithHeight(
                          16, Colors.grey, FontWeight.bold, 1.8),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.price}",
                      style: appStyle(25, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          'Colors',
                          style: appStyle(15, Colors.black, FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ChoiceChip(
                          label: const Text(""),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                          disabledColor: Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
