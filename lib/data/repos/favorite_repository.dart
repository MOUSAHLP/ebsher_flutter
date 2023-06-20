import 'package:dartz/dartz.dart';
import '../../core/api_const.dart';
import '../../models/vendor_model.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';
class FavoriteRepository {

  static Future<Either<String, List<VendorModel>>> getFavoriteList() {
    return BaseApiClient.get<List<VendorModel>>(

        url: ApiConst.getFavorite,
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }

  static Future<Either<String, String>> addFavorite(int idVendor) {
    return BaseApiClient.post<String>(
        queryParameters: {
          "vendor_id":idVendor,
        },
        url: ApiConst.addFavorite,
        converter: (e) {
          return e;
        });
  }
  static Future<Either<String, String>> removeFavorite(int idVendor) {
    return BaseApiClient.post<String>(
        queryParameters: {
          "vendor_id":idVendor,
        },
        url: ApiConst.removeFavorite,
        converter: (e) {
          return e;
        });
  }
}
