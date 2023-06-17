import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/login_response.dart';
import 'datastore_keys.dart';

class DataStore {
  DataStore._internal();

  static final DataStore _instance = DataStore._internal();

  static DataStore get instance => _instance;

  late Box<dynamic> box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LoginResponseAdapter());
    box = await Hive.openBox(DataStoreKeys.box);
    log("Datastore initialized", name: "$runtimeType");
  }

  /// Lang
  String get lang => box.get(DataStoreKeys.lang, defaultValue: "en")!;

  Future<void> setLang(String value) => box.put(DataStoreKeys.lang, value);

  /// Token
  bool get hasToken => box.containsKey(DataStoreKeys.token);

  String? get token {
    if (!box.containsKey(DataStoreKeys.token)) return null;
    return "${box.get(DataStoreKeys.token)}";
  }

  Future<void> setToken(String value) => box.put(DataStoreKeys.token, value);

  void deleteToken() => box.deleteAll({DataStoreKeys.token});

  /// User Info
  Future<void> setUserInfo(LoginResponse value) =>
      box.put(DataStoreKeys.userInfo, value);

  LoginResponse? get userInfo {
    if (!box.containsKey(DataStoreKeys.userInfo)) return null;
    return box.get(DataStoreKeys.userInfo);
  }

  void deleteUserInfo() => box.deleteAll({DataStoreKeys.userInfo});

  /// Terms Accepted
  bool get termsViewed {
    if (!box.containsKey(DataStoreKeys.termsAccepted)) return false;
    return box.get(DataStoreKeys.termsAccepted);
  }

  Future<void> setTermsIsViewed() => box.put(DataStoreKeys.termsAccepted, true);
}
