import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CounterWidget extends StatelessWidget {
  final String productId;
  final int? quantity;
  final double price;
  final String title;
  final String image;

  CounterWidget(
      {required this.productId,
      this.quantity,
      required this.price,
      required this.title,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 30,
          child: (quantity == null)
              ? Text(
                  '',
                  textScaleFactor: 1.5,
                )
              : FittedBox(
                  child: Text(
                    '\$${(quantity! * price).toStringAsFixed(2)}',
                    textScaleFactor: 1.5,
                  ),
                ),
        ),
        SizedBox(
          height: 30,
          child: Center(
            child: (quantity == null)
                ? GestureDetector(
                    onTap: () {
                      cart.addCartItem(productId, price, title, image);
                    },
                    child: Container(
                      child: Center(child: Text('ADD')),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFAFBEC4).withOpacity(0.5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Icon(Icons.remove),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFAFBEC4).withOpacity(0.5),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onTap: () {
                          cart.removeSingleItem(productId);
                        },
                      ),
                      FittedBox(
                        child: Text('$quantity'),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Icon(
                            Icons.add,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFAFBEC4).withOpacity(0.5),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onTap: () {
                          cart.addSingleItem(productId);
                        },
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
