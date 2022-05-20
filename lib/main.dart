import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_fakeapi/providers/cart.dart';
import 'package:shopping_app_fakeapi/providers/product.dart';
import 'package:shopping_app_fakeapi/providers/products.dart';
import 'package:shopping_app_fakeapi/screens/bottom_nav_bar.dart';
import 'package:shopping_app_fakeapi/screens/intro_screen.dart';
import 'package:shopping_app_fakeapi/screens/order_confirmation_screen.dart';
import 'package:shopping_app_fakeapi/screens/product_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Product(
              image: '',
              description: '',
              category: '',
              title: '',
              id: '',
              price: 0,
              rate: 0,
              count: 0),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            headline2: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            headline3: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            headline4: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        home: IntroScreen(),
        routes: {
          BottomNavBar.routeName: (ctx) => BottomNavBar(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrderConfirmationScreen.routeName: (ctx) => OrderConfirmationScreen(),
        },
      ),
    );
  }
}
