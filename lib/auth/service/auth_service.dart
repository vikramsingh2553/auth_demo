import 'package:auth_demo/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future createAccount(UserModel userModel) async {
    UserCredential credential=
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
    User? user = credential.user;
    print('Account created');

  }

  Future login(UserModel userModel) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user');
      }
    }
  }

  Future logOut ()async{
await FirebaseAuth.instance.signOut();

  }

}
