import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/counter_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context);
    Widget _ratingWidget() {
      if (selectedProduct.rate < 5 / 3) {
        return Icon(
          Icons.star_border,
          color: Colors.amber,
          size: 30,
        );
      }
      if (selectedProduct.rate < 10 / 3) {
        return Icon(
          Icons.star_half_outlined,
          color: Colors.amber,
          size: 30,
        );
      } else {
        return Icon(
          Icons.star,
          color: Colors.amber,
          size: 30,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ratingWidget(),
              SizedBox(
                width: 5,
              ),
              Text(
                selectedProduct.rate.toString(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'By ${selectedProduct.count} customers',
                textScaleFactor: 0.9,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
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
              padding: EdgeInsets.all(20),
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
                                  textScaleFactor: 1.2,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                                height: 80,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '\$${selectedProduct.price}',
                                textScaleFactor: 1.2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
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
                  Divider(
                    height: 40,
                    thickness: 2,
                  ),
                  Text(
                    'Category : ${selectedProduct.category}',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    selectedProduct.description,
                    textScaleFactor: 1.2,
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
