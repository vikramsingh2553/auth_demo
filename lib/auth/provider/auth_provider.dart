import 'package:auth_demo/auth/core/storage_helper.dart';
import 'package:auth_demo/auth/model/user_model.dart';
import 'package:auth_demo/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isLoggedIn = false;

  Future createAccount(UserModel userModel) async {
    try {
      isError = false;
      isLoading = true;
      notifyListeners();

      AuthService authService = Get.find();
      await authService.createAccount(userModel);

      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isError = true;
      isLoading = false;
      notifyListeners();

      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
      } else {
        Fluttertoast.showToast(msg: 'Auth Error ${e.code}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }

  Future login(UserModel userModel) async {
    try {
      isError = false;
      isLoading = true;
      notifyListeners();

      AuthService authService = Get.find();
      await authService.login(userModel);

      StorageHelper storageHelper = Get.find();
      await storageHelper.saveLoginStatus();

      isLoading = false;
      isLoggedIn = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isError = true;
      isLoading = false;
      notifyListeners();

      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      } else {
        Fluttertoast.showToast(msg: 'Auth Error ${e.code}');
      }
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signOut();

      StorageHelper storageHelper = Get.find();
      await storageHelper.removeLoginStatus();

      isLoading = false;
      isError = false;
      isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }

  Future loadLoginStatus() async {
    StorageHelper storageHelper = Get.find();
    isLoggedIn = await storageHelper.getLoginStatus();
    notifyListeners();
  }

  Future<void> googleSignIn() async {
    isLoading = true;
    notifyListeners();

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        isError = false;
        StorageHelper storageHelper = Get.find();
        await storageHelper.saveLoginStatus();
        isLoggedIn = true;
      } else {
        isError = true;
      }
    } catch (error) {
      isError = true;
    }

    isLoading = false;
    notifyListeners();
  }
}
