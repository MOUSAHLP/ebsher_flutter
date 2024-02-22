import 'package:absher/models/vendor_model.dart';

import 'package:dartz/dartz.dart';

import '../../core/api_const.dart';

import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class LocationRepository {
  static Future<Either<String, List<VendorModel>>> getVendorsNear(
      {required double latitude, required double longitude}) {
    return BaseApiClient.get<List<VendorModel>>(
        url: ApiConst.getNearByVendors(latitude: latitude, longitude: longitude),
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }
}
