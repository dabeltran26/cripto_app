import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cripto_app/resources/models/coin_model.dart';

class FirebaseFavoriteServices {
  final FirebaseFirestore firestore;

  FirebaseFavoriteServices({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  Future<bool> deleteFavorite(String uid, CoinModel coin) async {
    try {
      await firestore.collection('users').doc(uid).collection('favorites').doc(coin.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CoinModel>> getFavoriteProducts(String uid) async {
    try {
      final querySnapshot = await firestore.collection('users').doc(uid).collection('favorites').get();
      final favorites = querySnapshot.docs.map((doc) {
        return CoinModel.fromMap(doc.data());
      }).toList();
      return favorites;
    } catch (e) {
      return [];
    }
  }
}
