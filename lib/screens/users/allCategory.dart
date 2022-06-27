import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/users/cartScreen.dart';
import 'package:global_market/screens/users/productInfo.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AllCategories extends StatefulWidget {
  static String id = 'AllCategories';

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  List<Product> products;
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            LocaleKeys.All_Category.tr(),
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            // new IconButton(
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.white,
            //     ),
            //     onPressed: () {}),
            new IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                }),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> _products = [];
                for (var doc in snapshot.data.docs) {
                  var data = doc;
                  _products.add(Product(
                      pId: doc.id,
                      pName: data[kProductName],
                      pPrice: data[kProductPrice],
                      pDescription: data[kProductDescription],
                      pImg: data[kProductImg],
                      pCategory: data[kProductCategory],
                      brand: data[kPBrand]));
                }
                _products = [..._products];
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductInfo.id,
                            arguments: _products[index]);
                      },
                      child: Stack(children: <Widget>[
                        Positioned.fill(
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(_products[index].pImg),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('\$ ${_products[index].pPrice}')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  itemCount: _products.length,
                );
              } else {
                return Center(child: Text('Loading...'));
              }
            }));
  }
}
