import 'package:auth_demo/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> createAccount(UserModel userModel) async {
    try {
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      print('Account created: ${credential.user?.email}');
    } catch (e) {
      print('Failed to create account: $e');
    }
  }

  Future<void> login(UserModel userModel) async {
    try {
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      print('Login successfully: ${credential.user?.email}');
    } catch (e) {
      print('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      print('Logged out successfully');
    } catch (e) {
      print('Failed to logout: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google Sign-In aborted');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;
      print('Google Sign-In successful: ${user?.email}');
    } catch (e) {
      print('Failed to sign in with Google: $e');
    }
  }
}
