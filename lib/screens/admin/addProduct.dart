import 'package:buy_it/models/product.dart';
import 'package:buy_it/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';

class AddProduct extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            custom_text_field(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            custom_text_field(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            SizedBox(
              height: 10,
            ),
            custom_text_field(
              hint: 'Product Description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            custom_text_field(
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category',
            ),
            SizedBox(
              height: 10,
            ),
            custom_text_field(
                onClick: (value) {
                  _imageLocation = value;
                },
                hint: 'Product Location'),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pDescription: _description,
                      pLocation: _imageLocation,
                      pCategory: _category));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
