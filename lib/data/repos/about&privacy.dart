

import 'package:dartz/dartz.dart';
import '../../core/api_const.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';
class AboutAndPrivacyRepository {
  static Future<Either<String, String>> getAbout() {
    return BaseApiClient.get<String>(
        url: ApiConst.getAbout,
        converter: (e) {
          return e['data']['content'];
        });
  }
  static Future<Either<String, String>> getPrivacy() {
    return BaseApiClient.get<String>(
        url: ApiConst.getPrivacy,
        converter: (e) {
          return e['data']['content'];
        });
  }
}
