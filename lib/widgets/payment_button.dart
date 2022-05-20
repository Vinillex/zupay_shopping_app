import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/order_confirmation_screen.dart';

class PaymentButton extends StatefulWidget{
  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, OrderConfirmationScreen.routeName);
        Timer(Duration(seconds: 1),()=>cart.clearCart());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C1C19),
          borderRadius: BorderRadius.circular(6),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Center(
          child: Text(
            'Order Now',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
