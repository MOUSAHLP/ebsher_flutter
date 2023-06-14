
import 'package:absher/models/notification_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/api_const.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';
class NotificationRepository {
  static Future<Either<String, List<NotificationModel>>> getNotifications() {
    return BaseApiClient.get<List<NotificationModel>>(
        url: ApiConst.getNotifications,
        converter: (e) {
          return NotificationModel.listFromJson(e["data"]);
        });
  }
  static Future<Either<String, String>> getAbout() {
    return BaseApiClient.get<String>(
        url: ApiConst.getAbout,
        converter: (e) {
          return e['data']['content'];
        });
  }
}
