import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/core/models/product_model.dart';

import '../models/cart_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('products').get();

      final products = snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data());
      }).toList();

      return products;
    } catch (e) {
      // Handle any errors here
      rethrow;
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();

      final List<ProductModel> products = querySnapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      // Handle the error as needed, e.g., log the error or throw an exception
      rethrow;
    }
  }

 Future<void> addToCart(CartModel cartItem) async {
    try {
      await _firestore.collection('carts').add({
        'productId': cartItem.productId,
        'productName': cartItem.productName,
        'price': cartItem.price,
        'quantity': cartItem.quantity,
        'imageUrl':cartItem.imageUrl
      });
    } catch (e) {
      rethrow;
    }
  }

// Future<ProductModel?> getProductById(String productId) async {
//   ProductModel? productModel;
//   DocumentSnapshot productSnapshot =
//       await FirebaseFirestore.instance.collection("products").doc(productId).get();
//   if (productSnapshot.exists) {
//     productModel = ProductModel.fromMap(productSnapshot.data() as Map<String, dynamic>);
//   }
//   return productModel;
// }

}
