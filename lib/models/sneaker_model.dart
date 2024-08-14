import 'dart:convert';

List<SneakerModel> sneakersFromJson(String str) => List<SneakerModel>.from(
    jsonDecode(str).map((x) => SneakerModel.fromJson(x)));

class SneakerModel {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;
  final String title;

  SneakerModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.oldPrice,
      required this.sizes,
      required this.price,
      required this.description,
      required this.title});

  factory SneakerModel.fromJson(Map<String, dynamic> json) => SneakerModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        imageUrl: json['imageUrl'].cast<String>(),
        oldPrice: json['oldPrice'],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        price: json['price'],
        description: json['description'],
        title: json['title'],
      );
}
