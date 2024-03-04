import 'dart:convert';
import 'dart:developer';
import 'package:absher/models/city_name_model.dart';
import 'package:absher/models/reels_model.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/api_const.dart';
import '../../models/exihibtions_model.dart';
import '../../models/home_model.dart';
import '../../models/params/get_vendors_exhibitions_params.dart';
import '../../models/params/get_vendors_params.dart';
import '../../models/params/search_params.dart';
import '../../models/profile_model.dart';
import '../../models/sub_category_response.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class ExhibitionsRepository {

  static Future<Either<String,List< ExhibitionsModel>>> getExhibitions() {
    return BaseApiClient.get<List< ExhibitionsModel>>(
        url: ApiConst.getExhibitions,
        converter: (e) {
          return ExhibitionsModel.listFromJson(e['data']);
        });
  }
//GetVendorsExhibitionsParams
  static Future<Either<String, List<VendorModel>>> getVendorsExhibitionsList({required GetVendorsExhibitionsParams getVendorsParams}) {
    BaseApiClient.getVendorsCancelToken.cancel('CancleS');
    BaseApiClient.getVendorsCancelToken = CancelToken();
    print("getVendorsParams.toJson()");
    print(getVendorsParams.toJson());
    return BaseApiClient.get<List<VendorModel>>(
      url: ApiConst.getVendorsExhibitionsList,
      queryParameters: getVendorsParams.toJson(),
      converter: (e) {
        return VendorModel.listFromJson(e);
      },
      cancelToken: BaseApiClient.getVendorsCancelToken,
    );}
}
