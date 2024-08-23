import 'dart:convert';
import 'package:flutter/services.dart';

abstract class JsonReader {
  static late Map<String, dynamic> _config;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('env/env.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static void cleanEnv() {
    _config['env'] = "";
  }

  static void setEnv(String key) {
    _config['env'] = key;
  }

  static void setUrlEnv(String url) {
    _config['base_url'] = url;
  }

  static String getNameConfig(String name) {
    return _config[name] as String;
  }
}
