import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_grid.dart';
import '../widgets/product_widget.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Future<void> _refreshScreen(BuildContext context) async {
  //   await Provider.of<Products>(context, listen: false).fetchAndSetData();
  // }

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
                      icon: Icon(Icons.menu),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
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
              ? Container(
            height: MediaQuery.of(context).size.height*0.8,
                child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
              )
              : ProductGrid(),
        ),
      ],
    );
  }
}
