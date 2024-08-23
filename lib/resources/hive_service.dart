import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

class HiveService {
  static Future<void> initHive() async {
    final appDocumentDir = await path.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox('firebase_token');
  }

  static Future<void> saveFirebaseToken(token) async {
    var box = Hive.box('firebase_token');
    box.put('firebase_token', token);
  }

  static String getFirebaseToken() {
    var box = Hive.box('firebase_token');
    return box.get('firebase_token') ?? '';
  }
}
