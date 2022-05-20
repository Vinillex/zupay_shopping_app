import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_fakeapi/screens/products_screen.dart';


import '../providers/cart.dart';
import '../widgets/payment_widget.dart';
import 'cart_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = '/bottom-nav';

  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    ProductScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (cart.totalAmount > 0 && _selectedIndex == 1) ? const PaymentWidget() : Container(),
          Container(
            color: const Color(0xFFFEFEFE),
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
            child: GNav(
              textStyle: const TextStyle(
                color: Color(0xFF1C1C19),
                fontSize: 13,
              ),
              tabBorderRadius: 15,
              iconSize: 30,
              backgroundColor: const Color(0xFFFEFEFE),
              tabBackgroundColor: const Color(0xFF6B718B).withOpacity(0.1),
              gap: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              tabs: const [
                GButton(
                  iconColor: Color(0xFFAFBEC4),
                  iconActiveColor: Color(0xFF1C1C19),
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  iconColor: Color(0xFFAFBEC4),
                  iconActiveColor: Color(0xFF1C1C19),
                  icon: Icons.shopping_bag_outlined,
                  text: 'Cart',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index){
                setState(() {
                  _selectedIndex  = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
