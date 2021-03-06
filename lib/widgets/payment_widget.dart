import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_fakeapi/widgets/payment_button.dart';

import '../providers/cart.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Card(
      color: const Color(0xFFFEFEFE),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20,),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total',style: Theme.of(context).textTheme.headlineLarge,),
                Text(
                  '\$' + cart.totalAmount.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const PaymentButton(),
          ],
        ),
      ),
    );
  }
}
