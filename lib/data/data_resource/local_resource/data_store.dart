import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/login_response.dart';

class DataStore {
  DataStore._internal();

  static final DataStore _instance = DataStore._internal();

  static DataStore get instance => _instance;

  late Box<dynamic> box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LoginResponseAdapter());
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

  Future<void> setUserInfo(LoginResponse value) => box.put("userInfo", value);

  LoginResponse? get userInfo {
    if (!box.containsKey("userInfo")) return null;
    return box.get("userInfo");
  }

  void deleteUserInfo() => box.deleteAll({"userInfo"});

  void deleteToken() => box.deleteAll({"token"});
}
