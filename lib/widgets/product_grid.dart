import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_fakeapi/widgets/product_widget.dart';

import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: productProvider.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: productProvider.products[i],
          child: ProductWidget(),
        );
      },
    );
  }
}
