import 'package:flutter/foundation.dart';

class CartItem with ChangeNotifier{
  final String id;
  final String title;
  final String image;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  CartItem? findById(String productId){
    if(_items.containsKey(productId)){
      return _items.values.firstWhere((cartItem) => cartItem.id == productId);
    }
    return null;
  }


  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void addSingleItem(String productId){
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as int > 0) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            image: existingCartItem.image,
            quantity: existingCartItem.quantity + 1,
            price: existingCartItem.price),
      );
    }else {
      return;
    }
    notifyListeners();
  }

  void addCartItem(
      String productId,
      double price,
      String title,
      String image,
      ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          image: existingCartItem.image,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
            () => CartItem(
          id: productId,
          title: title,
          image: image,
          quantity: 1,
          price: price,
        ),
      );
      notifyListeners();
    }
  }

  void removeCartItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as int > 1) {
      _items.update(
        productId,
            (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            image: existingCartItem.image,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price),
      );
    }else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
