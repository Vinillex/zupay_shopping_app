import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductWidget extends StatelessWidget {
  // final String productId;
  // final String title;
  // final String category;
  // final String image;
  // final double price;
  // ProductWidget({required this.productId,required this.title,required this.category,required this.image,required this.price});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context,listen: false);
    return Container(
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headline3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      IconButton(
                        onPressed: () {
                          Scaffold.of(context).hideCurrentSnackBar();
                          cart.addCartItem(product.id, product.price ,product.title, product.image);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Color(0xFFFEFEFE).withOpacity(0.9),
                            content: Text('Added Item to Cart',style: TextStyle(color: Colors.grey[600]),),
                            action: SnackBarAction(
                              label: 'UNDO',
                              textColor: Colors.black,
                              onPressed: () {
                                cart.removeSingleItem(product.id);
                              },
                            ),
                          ));
                        },
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
