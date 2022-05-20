import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/counter_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context);
    Widget _ratingWidget() {
      if (selectedProduct.rate < 5 / 3) {
        return const Icon(
          Icons.star_border,
          color: Colors.orange,
          size: 3,
        );
      }
      if (selectedProduct.rate < 10 / 3) {
        return const Icon(
          Icons.star_half_outlined,
          color: Colors.orange,
          size: 30,
        );
      } else {
        return const Icon(
          Icons.star,
          color: Colors.orange,
          size: 30,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ratingWidget(),
              const SizedBox(
                width: 5,
              ),
              Text(
                selectedProduct.rate.toString(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'by ${selectedProduct.count} customers',
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: Image.network(
                selectedProduct.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  selectedProduct.title,
                                  style: Theme.of(context).textTheme.headline4,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                                height: 80,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '\$${selectedProduct.price}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 2,
                          child: CounterWidget(
                            productId: productId,
                            quantity: cart.findById(productId)?.quantity,
                            image: selectedProduct.image,
                            price: selectedProduct.price,
                            title: selectedProduct.title,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 40,
                    thickness: 2,
                  ),
                  Text(
                    'Category : ${selectedProduct.category}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    selectedProduct.description,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 15,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
