import 'package:flutter/material.dart';
import 'package:openinventory_student_app/api/responses/item.dart';
import 'package:openinventory_student_app/api/responses/labitem.dart';
import 'package:provider/provider.dart';

class CartController extends ChangeNotifier {
  static const CART_LIMIT = 4;
  final Map<String, Set<CartItem>> cart = {};

  /// Helper method to get controller by context
  static CartController of(BuildContext context) {
    return Provider.of<CartController>(context, listen: false);
  }

  /// Helper method to get controller by context
  ///
  /// This also starts litening for future changes
  static CartController listenOf(BuildContext context) {
    return Provider.of<CartController>(context, listen: true);
  }

  /// Given a cart id, add an item
  ///
  /// Howvever if cart id is not defined, the cart is then created.
  /// Cart max space req are also ensured
  void addItem(String cartId, CartItem item) {
    if (!cart.containsKey(cartId)) {
      cart[cartId] = Set();
    }

    if (cart[cartId].length < CART_LIMIT) {
      cart[cartId].add(item);
    }
    notifyListeners();
  }

  /// Removes a item from cart if the cart and item exists
  void removeItem(String cartId, CartItem item) {
    if (!cart.containsKey(cartId)) {
      return;
    }

    if (cart[cartId].contains(item)) {
      cart[cartId].remove(item);
    }
    notifyListeners();
  }

  /// Getter for cart items in a cart
  Set<CartItem> getCartItems(String cartId) {
    if (!cart.containsKey(cartId)) {
      cart[cartId] = Set();
    }
    return cart[cartId];
  }

  /// Checks if the item is in the cart
  bool isInCart(String cartId, CartItem itemId) {
    if (!cart.containsKey(cartId)) {
      return false;
    }
    return cart[cartId].contains(itemId);
  }
}

/// Data class with operators overloaded to be used as cart item
class CartItem {
  final String id;
  final String title;
  final String image;

  CartItem(this.id, this.title, this.image);

  factory CartItem.fromLabItemResponse(LabItemResponse labItem) {
    return CartItem(labItem.id, labItem.itemSet.title, labItem.itemSet.image);
  }

  factory CartItem.fromItemResponse(ItemResponse item) {
    return CartItem(item.id, item.itemSet.title, item.itemSet.image);
  }

  @override
  int get hashCode => id.hashCode;

  @override
  operator ==(other) {
    return other is CartItem && id == other.id;
  }
}
