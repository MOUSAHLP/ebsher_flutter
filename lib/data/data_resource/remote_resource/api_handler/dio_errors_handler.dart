import 'dart:io';
import "package:dio/dio.dart";

class DioErrorsHandler {
  static Map data = {"statusCode": -1, "message": "Unknown Error"};

  static dynamic onError(DioError e) {
    if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      data["message"] = "Request timeout";
      data["statusCode"] = 408;
    } else if (e.error is SocketException ||
        e.type == DioErrorType.connectionError) {
      data["message"] = "No Internet Connection!";
    } else if (e.type == DioErrorType.cancel) {
      data["message"] = "Request canceled!";
    } else if (e.response != null &&
        e.response?.statusCode != null &&
        e.response?.statusMessage != null) {
      print(e.response!.data);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
      data["message"] = e.response!.data["message"];
      data["statusCode"] = e.response!.data["returnedCode"];
    } else if (e.type == DioErrorType.unknown ||
        e.type == DioErrorType.badCertificate ||
        e.type == DioErrorType.badResponse) {
      data["message"] = "Something Went Wrong";
    }
    return data;
  }
}
