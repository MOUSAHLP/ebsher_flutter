import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../local_resource/data_store.dart';
import '../links.dart';
import 'dio_errors_handler.dart';
import 'interceptors_handler.dart';

class BaseApiClient {
  static Dio client = Dio();
  static const String _acceptHeader = 'application/json';

  BaseApiClient() {
    client.interceptors.add(LogInterceptor());
    if (kDebugMode) {
      // client.interceptors.add(PrettyDioLogger(
      //     requestHeader: true, responseHeader: true, request: true));
    }
    client.interceptors.add(ClientInterceptor());
    client.options.baseUrl = Links.baseUrl;
  }

  static Future<Either<String, dynamic>> post(
      {required String url,
      FormData? formData,
      Map<String, dynamic>? queryParameters,
      required Function(dynamic) converter,
      dynamic returnOnError}) async {
    try {
      var response = await client.post(
        url,
        queryParameters: queryParameters,
        data: formData,
        onSendProgress: (int sent, int total) {
          if (kDebugMode) {
            print(
                'progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
          }
        },
        options: Options(
          headers: {
            'accept': _acceptHeader,
            'authorization': 'Bearer ${DataStore.instance.token ?? ''}',
          },
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }

        // toast(response.data['message']);
        return right(converter(response.data));
      } else {
        return left(response.data['message']);
      }
    } on DioError catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      // toast(dioError['message']);

      if (kDebugMode) {
        print(e);
      }
      return left(returnOnError ?? e.response?.data['message'] ?? '');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(e.toString());
    }
  }

  static Future put(
      {required String url,
      FormData? formData,
      Map<String, dynamic>? queryParameters,
      required Function(dynamic) converter,
      dynamic returnOnError}) async {
    try {
      var response = await client.put(
        url,
        data: formData,
        queryParameters: queryParameters,
        onSendProgress: (int sent, int total) {
          if (kDebugMode) {
            print(
                'progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
          }
        },
        options: Options(
          headers: {
            'accept': _acceptHeader,
            'authorization': 'Bearer ${DataStore.instance.token ?? ''}',
          },
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
        return converter(response.data);
      }
    } on DioError catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      // toast(dioError['message']);
      if (kDebugMode) {
        print(e);
      }
      return returnOnError ?? e.response?.data['message'] ?? '';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future get(
      {required String url,
      Map<String, dynamic>? queryParameters,
      required Function(dynamic) converter}) async {
    try {
      var response = await client.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'accept': _acceptHeader,
            'authorization': 'Bearer ${DataStore.instance.token ?? ''}',
          },
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
        return converter(response.data);
      }
    } on DioError catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      // toast(dioError['message']);
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future delete(
      {required String url,
      Map<String, dynamic>? queryParameters,
      required Function(dynamic) converter}) async {
    try {
      var response = await client.delete(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'accept': _acceptHeader,
            'authorization': 'Bearer ${DataStore.instance.token ?? ''}',
          },
        ),
      );
      if (response.statusCode! >= 200 || response.statusCode! <= 205) {
        if (kDebugMode) {
          print(response.data);
        }
        return converter(response.data);
      }
    } on DioError catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      // toast(dioError['message']);
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
