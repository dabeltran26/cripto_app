import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cripto_app/resources/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProfileService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseProfileService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance;

  Future<bool> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(user.uid).update(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
