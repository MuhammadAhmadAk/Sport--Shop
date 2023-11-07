import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/Repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  AuthRepository authRepository = AuthRepository();
  Future<void> registor(
    String name,
    String email,
    String password,
  ) async {
    emit(AuthLoadingState());
    try {
      var user = await authRepository.registor(
        name,
        email,
        password,
      );
      emit(AuthRegisterSuccessfullState(userModel: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      var user = await authRepository.login(email, password);
      if (user != null) {
        emit(AuthLoggedInState(userModel: user));
      } else {
        emit(AuthErrorState(error: "User not availible"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
