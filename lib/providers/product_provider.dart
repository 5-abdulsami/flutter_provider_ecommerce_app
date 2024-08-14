import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/models/sneaker_model.dart';
import 'package:flutter_ecommerce_app/services/helper.dart';

class ProductProvider extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;
  List<dynamic> get shoeSizes => _shoeSizes;
  List<String> get sizes => _sizes;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  //This function is called with an index, it toggles the
  //selection of this item, and leave the selection of all
  //other items as they were, allowing multiple items to be
  //selected at once
  void toggleStatus(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
        notifyListeners();
      }
    }
  }

  late Future<List<SneakerModel>> male;
  void getMale() {
    male = Helper().getMaleSneakers();
  }

  //Female Sneakers
  late Future<List<SneakerModel>> female;
  void getFemale() {
    female = Helper().getFemaleShoes();
  }

  //Kids Sneakers
  late Future<List<SneakerModel>> kids;
  void getKids() {
    kids = Helper().getKidsSneakers();
  }

  late Future<SneakerModel> sneaker;

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakersById(id);
    } else if (category == "Women Shoes") {
      sneaker = Helper().getFemaleShoesById(id);
    } else {
      sneaker = Helper().getKidsSneakersById(id);
    }
  }
}
