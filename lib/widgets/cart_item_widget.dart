import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import 'counter_widget.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final double price;
  int quantity;

  CartItemWidget({Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    // final product = Provider.of<Product>(context);
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyText2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('\$$price',style: Theme.of(context).textTheme.headline3,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: CounterWidget(
                        productId: id,
                        quantity: quantity,
                        price: price,
                        image: image,
                        title: title),
                  ),
                  // ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 40,
            thickness: 1,
            endIndent: 20,
            indent: 20,
          )
        ],
      ),
    );
  }
}
