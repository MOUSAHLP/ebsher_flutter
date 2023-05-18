import 'package:absher/models/category_response.dart';
import 'package:dartz/dartz.dart';

import '../../core/api_const.dart';
import '../../models/home_model.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class CategoryRepository{
 static Future<Either<String,HomeModel>> getCategory(
     ){
    return  BaseApiClient.get<HomeModel>(
        url: ApiConst.home,
        converter: (e) {
          return   HomeModel.fromJson(e['data']);
        });
  }
}