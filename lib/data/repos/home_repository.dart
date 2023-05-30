import 'package:absher/models/category_response.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/api_const.dart';
import '../../models/home_model.dart';
import '../../models/search_response.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class HomeRepository {
  static Future<Either<String, HomeModel>> getHomeData() {
    return BaseApiClient.get<HomeModel>(
        url: ApiConst.home,
        converter: (e) {
          return HomeModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, List<SearchResponse>>> getSearchCategory(
      {required String text}) {
    return BaseApiClient.get<List<SearchResponse>>(
        url: ApiConst.search + text,
        converter: (e) {
          return SearchResponse.listFromJson(e['vendors']);
        });
  }

  static Future<Either<String, List<VendorModel>>> getVendorsList(
      {required int categoryId}) {
    return BaseApiClient.get<List<VendorModel>>(
        url: ApiConst.vendorsList(categoryId),
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }
}
