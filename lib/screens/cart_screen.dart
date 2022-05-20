import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          pinned: false,
          floating: false,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            background: Center(
              child: Text(
                'Your Cart',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: (cart.totalAmount <= 0)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.88178 - 100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 200,
                          color: Colors.grey[600],
                        ),
                        Text('Your Cart is empty',style: Theme.of(context).textTheme.headline1,),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    ...cart.items.values.map(
                      (cart) => CartItemWidget(
                        id: cart.id,
                        image: cart.image,
                        title: cart.title,
                        price: cart.price,
                        quantity: cart.quantity,
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
