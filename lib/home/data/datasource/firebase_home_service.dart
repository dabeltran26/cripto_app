import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

class FirebaseHomeServices {
  final FirebaseFirestore firestore;

  FirebaseHomeServices({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  Future<bool> saveFavorite(String uid, CoinModel coin) async {
    try {
      await firestore.collection('users').doc(uid).collection('favorites').doc(coin.id).set(coin.toMap());
      return true;
    } catch (e) {
      return true;
    }
  }
}
