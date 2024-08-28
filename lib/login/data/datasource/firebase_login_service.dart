import 'package:cripto_app/resources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLoginService {
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;

  FirebaseLoginService({FirebaseFirestore? firestore, GoogleSignIn? googleSignIn})
      : googleSignIn = googleSignIn ?? GoogleSignIn(),
        firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> signInWithCredentials(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return false;
    } else {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    }
  }

  Future<UserModel?> getUserInfo(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        UserModel user = UserModel.fromMap(snapshot.data()!);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
