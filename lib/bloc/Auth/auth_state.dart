import 'package:shop_app/core/models/usermodel.dart';

class AuthState {}

final class AuthInitialState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final UserModel userModel;
  AuthLoggedInState({required this.userModel});
}

class AuthRegisterSuccessfullState extends AuthState {
  final UserModel userModel;
  AuthRegisterSuccessfullState({required this.userModel});
}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}
