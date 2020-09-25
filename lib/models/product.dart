import 'package:flutter/cupertino.dart';

class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pCategory;
  String pDescription;
  Product(
      {this.pName,
      this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pPrice});
}
