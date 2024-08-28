import 'package:cripto_app/resources/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

class HiveService {
  static Future<void> initHive() async {
    final appDocumentDir = await path.getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter(UserModelAdapter());
    await Hive.openBox('firebase_token');
    await Hive.openBox('user');
  }

  static Future<void> saveFirebaseToken(token) async {
    var box = Hive.box('firebase_token');
    box.put('firebase_token', token);
  }

  static String getFirebaseToken() {
    var box = Hive.box('firebase_token');
    return box.get('firebase_token') ?? '';
  }

  static Future<void> saveUser(UserModel user) async {
    final box = Hive.box('user');
    box.put('user', user);
  }

  static UserModel getUser() {
    final box = Hive.box('user');
    return box.get('user');
  }
}
