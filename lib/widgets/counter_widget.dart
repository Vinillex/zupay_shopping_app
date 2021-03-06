import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CounterWidget extends StatelessWidget {
  final String productId;
  final int? quantity;
  final double price;
  final String title;
  final String image;

  const CounterWidget(
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
                 style: Theme.of(context).textTheme.headline6,
                )
              : FittedBox(
                  child: Text(
                    '\$${(quantity! * price).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline6,
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
                      child: const Center(child: Text('ADD')),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFAFBEC4).withOpacity(0.5),
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
                          child: const Icon(Icons.remove),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFAFBEC4).withOpacity(0.5),
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
                        child: Text('$quantity',style: Theme.of(context).textTheme.headline2,),
                      ),
                      GestureDetector(
                        child: Container(
                          child: const Icon(
                            Icons.add,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFAFBEC4).withOpacity(0.5),
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
