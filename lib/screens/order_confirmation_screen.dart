import 'dart:async';

import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatefulWidget {
  static const routeName = '/order_confirmation';

  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with TickerProviderStateMixin {
  bool _isLoading = true;

  //double _size = 0;
  bool _startAnimation = false;

  void _orderComplete() async {
    setState(() {
      _isLoading = false;

      //_size = 200;
    });
    Timer(const Duration(seconds: 5), () => Navigator.of(context).pop());
    Timer(
        const Duration(seconds: 1),
        () => setState(() {
              _startAnimation = true;
            }));
    //print('hey');
    //Timer(Duration(seconds: 2),()=>Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      Timer(const Duration(seconds: 5), _orderComplete);
    }
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.black,
              )
            : AnimatedContainer(
                clipBehavior: Clip.hardEdge,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 5),
                height: _startAnimation ? 200 : 0,
                width: _startAnimation ? 200 : 0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/check2.png',
                ),
              ),
      ),
    );
  }
}
