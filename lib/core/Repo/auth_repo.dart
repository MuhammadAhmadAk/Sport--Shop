import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/core/models/usermodel.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  static User? logedInUser;
  Future<UserModel> registor(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      logedInUser = credential.user;
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, name: name, profilepic: '');
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap());

      return newUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> login(String email, String password) async {
    UserCredential credential;
    UserModel userModel;
    try {
      credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      String uid = credential.user!.uid;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      userModel = UserModel.fromMap(userData.data() as Map<String, dynamic>);

      return userModel;
    } catch (e) {
      Exception(e.toString());
      rethrow;
    }
  }

  static Future<UserModel?> getUserbyId(String uid) async {
    UserModel? userModel;
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (documentSnapshot.data() != null) {
      userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    }
    return userModel;
  }
}
