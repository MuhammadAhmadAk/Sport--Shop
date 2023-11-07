import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_model.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CartModel>? cartItems;
  Future<List<CartModel>?> getCartContents() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('carts').get();
      cartItems = snapshot.docs.map((e) {
        return CartModel.fromMap(e.data());
      }).toList();
      return cartItems;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeItemFromCart(CartModel item) async {
    try {
      // Assuming that each item in the cart is identified by a unique document ID.
      // Replace 'uniqueItemId' with the actual field name used to identify items in your cart.
      final itemDocument = _firestore.collection("carts").doc(item.productId);

      // Delete the item document from the 'cart' collection
      await itemDocument.delete();
    } catch (e) {
      rethrow;
      // You can handle the error in the CartCubit or UI layer
    }
  }
}
