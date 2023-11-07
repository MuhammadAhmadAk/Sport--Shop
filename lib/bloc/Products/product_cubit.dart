import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/Products/product_state.dart';
import 'package:shop_app/core/Repo/product_repo.dart';
import 'package:shop_app/core/models/product_model.dart';

import '../../core/models/cart_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  ProductRepository productRepository = ProductRepository();

  Future<void> getAllProducts() async {
    emit(ProductLoadingState());
    try {
      var products = await productRepository.getAllProducts();
      emit(ProductLoadedState(products: products));
    } catch (e) {
      emit(ProductErrorState(error: e.toString()));
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    emit(ProductLoadingState());
    try {
      var products = await productRepository.getProductsByCategory(category);
      emit(ProductLoadedState(products: products));
    } catch (e) {
      emit(ProductErrorState(error: e.toString()));
    }
  }

  void addToCart(CartModel cartItem) async {
    var currentState = state as ProductLoadedState;
    emit(ProductLoadingState());
    try {
      await productRepository.addToCart(cartItem);
      emit(
          AddtoCartState(cartModel: cartItem, products: currentState.products));
    } catch (e) {
      emit(ProductErrorState(error: e.toString()));
    }
  }

  void searchProducts(String query) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();

      if (snapshot.docs.isNotEmpty) {
        final products =
            snapshot.docs.map((doc) => ProductModel.fromMap(snapshot as Map<String,dynamic>)).toList();
        emit(ProductLoadedState(products: products));
      } else {
        // No products found, emit an empty state or display a message.
      }
    } catch (error) {
      // Handle errors, e.g., show an error message.
      emit(ProductErrorState(error: error.toString()));
    }
  }

  // Future<void> getProductById(String id) async {
  //   var currentState = state as ProductLoadedState;
  //   emit(ProductDetailLoadingState(products: currentState.products));
  //   try {
  //     var prd = await productRepository.getProductById(id);
  //     if (prd != null) {
  //       emit(ProductDetailsState(prd: prd, products: currentState.products));
  //     }
  //   } catch (e) {
  //     emit(ProductErrorState(error: e.toString()));
  //   }
  // }
}
