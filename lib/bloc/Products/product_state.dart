
import 'package:shop_app/core/models/cart_model.dart';
import 'package:shop_app/core/models/product_model.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoadedState extends ProductState {
  List<ProductModel> products;
  ProductLoadedState({required this.products});
}

class AddtoCartState extends ProductLoadedState {
  CartModel cartModel;
  AddtoCartState({required this.cartModel,required super.products});
}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});
}
