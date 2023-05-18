import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

class DataStore {
  DataStore._internal();
  static final DataStore _instance = DataStore._internal();
  static DataStore get instance => _instance;

  late Box<dynamic> box;

  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox("default_box");
    log("Datastore initialized", name: "$runtimeType");
  }

  bool get isDarkModeEnabled => box.get(
        "theme",
        defaultValue: false,
      )!;

  Future<void> switchTheme({required bool isDark}) => box.put(
        "theme",
        isDark,
      );

  String get lang => box.get("lang", defaultValue: "en")!;

  Future<void> setLang(String value) => box.put("lang", value);

  bool get hasToken => box.containsKey("token");

  String? get token {
    if (!box.containsKey("token")) return null;
    return "${box.get("token")}";
  }

  Future<void> setToken(String value) => box.put("token", value);

  void deleteToken() => box.deleteAll({"token"});
}
