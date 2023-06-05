import 'package:absher/models/category_response.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:absher/models/vendors_near_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/api_const.dart';
import '../../models/home_model.dart';
import '../../models/search_response.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class LocationRepository {

  static Future<Either<String, List<VendorsNearModel>>> getVendorsNear(
      {required double latitude,required double longitude }) {
    return BaseApiClient.post<List<VendorsNearModel>>(
        url: ApiConst.getNearbyvendors(latitude: 33.49033015986759, longitude: 36.33734044758082),
        converter: (e) {

          return VendorsNearModel.listFromJson(e['data']);
        });
  }



}
