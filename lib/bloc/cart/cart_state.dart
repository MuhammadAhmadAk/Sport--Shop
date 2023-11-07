import 'package:shop_app/core/models/cart_model.dart';

class CartState {}

final class CartInitialState extends CartState {}

class CartItemLoadedState extends CartState {
  List<CartModel>? cartItems;
  CartItemLoadedState({required this.cartItems});
}
class CartErrorState extends CartState {
  String error;
  CartErrorState({required this.error});
}
