import 'package:cripto_app/resources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRegisterServices {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseRegisterServices({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> signUpCredentials(String email, String pass) async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  Future<bool> saveUser(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set(user.toMap());
      return true;
    } catch (e) {
      return true;
    }
  }
}
