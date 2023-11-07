// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cart/cart_state.dart';
import 'package:shop_app/core/Repo/cart_repo.dart';
import 'package:shop_app/core/models/cart_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());
  CartRepository cartRepository = CartRepository();
  Future<void> getAllCartItems() async {
    try {
      var items = await cartRepository.getCartContents();
      emit(CartItemLoadedState(cartItems: items));
    } catch (e) {
      emit(CartErrorState(error: e.toString()));
    }
  }

  Future<void> removeItemCart(CartModel item) async {
    try {
      print("Removing item: ${item.productId}"); // Add this for debugging
      await cartRepository.removeItemFromCart(item);
      print("Item removed successfully.");
      final currentState = state as CartItemLoadedState;
      final updatedCartItems =
          List<CartModel>.from(currentState.cartItems!.toList())..remove(item);
      emit(CartItemLoadedState(cartItems: updatedCartItems));
    } catch (e) {
      print("Error removing item: $e"); // Add this for debugging
      emit(CartErrorState(error: e.toString()));
    }
  }

  void toggleItemSelection(CartModel item) {
    var curState = state as CartItemLoadedState;
    final List<CartModel> updatedCart =
        List<CartModel>.from(curState.cartItems!.toList());
    var index = updatedCart.indexWhere((element) => element == item);
    if (index != -1) {
      updatedCart[index].isSelected = !updatedCart[index].isSelected;
      emit(CartItemLoadedState(cartItems: updatedCart));
    }
  }
}
