import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRegisterServices {
  final FirebaseAuth _firebaseAuth;

  FirebaseRegisterServices({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> signUpCredentials(String email, String pass) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
  }
}
