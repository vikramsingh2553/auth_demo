import 'package:auth_demo/auth/model/user_model.dart';
import 'package:auth_demo/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
    bool isError = false;
  Future createAccount(UserModel userModel) async {
    try{
    isLoading = true;
    isError = true;
    AuthService authService = Get.find();
    await authService.createAccount(userModel);
    isLoading = false;
    notifyListeners();}
    on FirebaseAuthException catch (e) {
      isError=true;
      isLoading = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future login(UserModel userModel) async {
    try{
    isLoading = true;
    isError = true;
    AuthService authService = Get.find();
    await authService.login(userModel);
    isLoading = false;
    notifyListeners();
  } on FirebaseAuthException catch (e) {
      isError=true;
      notifyListeners();
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user');
      }
    }
}

Future logOut()async{
    try {
      isError=false;
      isLoading = true;
      notifyListeners();
      AuthProvider authProvider = Get.find();
      authProvider.logOut();
    }catch(e){
      isError=true;
      isLoading = false;
      notifyListeners();
    }
}

}
