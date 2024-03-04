import 'dart:convert';
import 'dart:developer';
import 'package:absher/models/city_name_model.dart';
import 'package:absher/models/reels_model.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/api_const.dart';
import '../../models/home_model.dart';
import '../../models/params/get_vendors_params.dart';
import '../../models/params/search_params.dart';
import '../../models/profile_model.dart';
import '../../models/sub_category_response.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class HomeRepository {
  static Future<Either<String, HomeModel>> getHomeData() {
    return BaseApiClient.get<HomeModel>(
        url: ApiConst.home,
        converter: (e) {
          log(e['data'].toString());
          return HomeModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, ProfileModel>> getProfile() {return BaseApiClient.get<ProfileModel>(
        url: ApiConst.profile,
        converter: (e) {
          return ProfileModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, List<VendorModel>>> getSearchCategory({required GetSearchParams text}) {
    BaseApiClient.getVendorsCancelToken.cancel('CancleS');
    BaseApiClient.getVendorsCancelToken = CancelToken();
    log("text.toJson()");
    print(text.toJson());
    return BaseApiClient.get<List<VendorModel>>(
        url: ApiConst.search,
        cancelToken: BaseApiClient.getVendorsCancelToken,
        queryParameters: text.toJson(),
        converter: (e) {
          return VendorModel.listFromJson(e);
        });
  }

  static Future<Either<String, List<VendorModel>>> getVendorsList({required GetVendorsParams getVendorsParams}) {
    BaseApiClient.getVendorsCancelToken.cancel('CancleS');
    BaseApiClient.getVendorsCancelToken = CancelToken();
    print("getVendorsParams.toJson()");
    print(getVendorsParams.toJson());
    return BaseApiClient.get<List<VendorModel>>(
      url: ApiConst.getVendorsList,
      queryParameters: getVendorsParams.toJson(),
      converter: (e) {
        return VendorModel.listFromJson(e);
      },
      cancelToken: BaseApiClient.getVendorsCancelToken,
    );
  }

  static Future<Either<String, SubCategoriesModel>> getSubCategory({required int categoryId}) {
    return BaseApiClient.get<SubCategoriesModel>(
        url: ApiConst.getSubCategories(categoryId),
        converter: (e) {
          return SubCategoriesModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, List<ReelsModel>>> getReels() {
    return BaseApiClient.get<List<ReelsModel>>(
        url: ApiConst.reels,
        converter: (e) {
          return ReelsModel.listFromJson(e["data"]);
        });
  }

  static Future<Either<String, VendorModel>> getVendorDetails({required int id}) {
    return BaseApiClient.get<VendorModel>(
        url: ApiConst.getVendorDetails(id),
        converter: (e) {
          return VendorModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, ProfileModel>> editProfile(ProfileModel? profileModel) async {
    String? imageFileName = profileModel?.avatar != null
        ? profileModel?.avatar?.split('/').last
        : '';
    return BaseApiClient.post<ProfileModel>(
        url: ApiConst.updateProfile,
        formData: FormData.fromMap({
          "name": profileModel?.name,
          "email": profileModel?.email,
          "phone": profileModel?.phone,
          if (profileModel?.avatar != null && profileModel!.avatar!.isNotEmpty)
            "avatar": await MultipartFile.fromFile(profileModel.avatar ?? "",
                filename: imageFileName),
        }),
        converter: (e) {
          return ProfileModel.fromJson(e['data']);
        });
  }

  static Future<Either<String, String>> seeStories(List<int> idStory) async {


    return BaseApiClient.post<String>(
        url: ApiConst.seenStories,
        formData: jsonEncode({
          "ids": idStory,
        }),
        converter: (e) {
          return e['data'].toString();
        });
  }

  static Future<Either<String, CityNameModel>> getCityName() async {
    return BaseApiClient.get<CityNameModel>(
        url: ApiConst.getCityName,
        converter: (p0) {

          return CityNameModel.fromJson(p0);
        });
  }

  static Future<Either<String, CityNameModel>> getRegionsName(int id) async {
    return BaseApiClient.get<CityNameModel>(
        url: "${ApiConst.getCityName}/$id",
        converter: (p0) {

          return CityNameModel.fromJson(p0);
        });
  }
}
