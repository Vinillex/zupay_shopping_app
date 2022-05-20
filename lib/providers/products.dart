import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shopping_app_fakeapi/providers/product.dart';

class Products with ChangeNotifier{
  List<Product> _products = [];

  List<Product> get products{
    return [..._products];
  }

  Product findById(String id){
    return products.firstWhere((prod) => prod.id == id);
  }
  
  Future<void> fetchAndSetData() async{
    final url = Uri.parse('https://fakestoreapi.com/products');
    //try{
      // final responsef = fetch('https://fakestoreapi.com/products')
      //     .then(res=>res.json())
      //   .then(json=>console.log(json))
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;//Map<String, dynamic>;
      print(extractedData);
      if(extractedData == null){
        return;
      }
      final List<Product> loadedProduct = [];
      extractedData.asMap().forEach((prodId, prodData) {
        // print(prodData['id']);
        // print(prodData['id'].runtimeType);
        loadedProduct.add(
          Product(
            id: prodData['id'].toString(),
            title: prodData['title'],
            price: double.parse(prodData['price'].toString()),
            category: prodData['category'],
            description: prodData['description'],
            image: prodData['image'],
            rate: double.parse(prodData['rating']['rate'].toString()),
            count: prodData['rating']['count']
          ),
        );
      });
      _products = loadedProduct;
      notifyListeners();
    //
  }
}