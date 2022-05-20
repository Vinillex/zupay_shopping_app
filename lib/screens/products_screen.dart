import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_grid.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  Future<void> didChangeDependencies() async{
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try{
        await Provider.of<Products>(context).fetchAndSetData();
          setState(() {
            _isLoading = false;
          });
      }catch(error){
        //print('error');
        _showErrorDialog('Oops !!! Something went wrong');
      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Future<void> _refreshScreen(BuildContext context) async {
  //   await Provider.of<Products>(context, listen: false).fetchAndSetData();
  // }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error Occurred'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 100,),
            Text(message,style: Theme.of(context).textTheme.headline3,),
            const SizedBox(
              height: 20,
            ),
            Text('Try again later',style: Theme.of(context).textTheme.headline2,)
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Timer(const Duration(milliseconds: 500), ()=> SystemNavigator.pop());
            },
            child: Text('Okay', style: Theme.of(context).textTheme.button,),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: true,
          expandedHeight: 100,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              stops: [0.8, 1],
              colors: [Color(0xFFF3F4F6), Color(0xDFF3F4F6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              expandedTitleScale: 1,
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              title: Text(
                'New Arrival',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                )
              : const ProductGrid(),
        ),
      ],
    );
  }
}
