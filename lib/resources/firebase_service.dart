import 'package:cripto_app/login/domain/models/user_google_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseServices({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<UserCredential> signInWithCredentials(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
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

  Future<UserCredential> signUpCredentials(String email, String pass) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
  }

  Future<Future<List>> singOut() async {
    return Future.wait([FirebaseAuth.instance.signOut(), _googleSignIn.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserGoogleModel> getUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    final googleUser = _googleSignIn.currentUser;
    UserGoogleModel user =
        UserGoogleModel(uid: firebaseUser!.uid, userName: googleUser!.displayName!, email: googleUser.email);
    return user;
  }
}
