import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool _startAnimation = false;

  void _doIt (){
    setState(() {
      _startAnimation = true;
    });
    print('nav');
    Timer(Duration(seconds: 5),()=> Navigator.of(context).pushReplacementNamed(BottomNavBar.routeName));
  }

  @override
  Widget build(BuildContext context) {
    print('start');
    if(_startAnimation == false){
      Timer(Duration(milliseconds: 500),_doIt);
    }
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          clipBehavior: Clip.hardEdge,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(seconds: 5),
          height: _startAnimation ? 200 : 0,
          width: _startAnimation ? 200 : 0,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset(
            'assets/logo-social.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
