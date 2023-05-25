import 'dart:developer';

import 'package:absher/core/api_const.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
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
    client.options.baseUrl = ApiConst.baseUrl;
  }

  static Future<Either<String, T>> post<T>(
      {required String url,
      FormData? formData,
      Map<String, dynamic>? queryParameters,
      required T Function(dynamic) converter,
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
      if (((response.statusCode! >= 200 || response.statusCode! <= 205)) &&
          (response.data['error'].toString() != 'true')) {
        if (kDebugMode) {
          log(response.data.toString());
        }
        return right(converter(response.data));
      } else {
        return left(response.data['message']);
      }
    } on DioError catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      if (kDebugMode) {
        print(e);
      }
      return left(returnOnError ?? dioError["message"] ?? '');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left("");
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

  static Future<Either<String, T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
  }) async {
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
          log(response.data.toString());
          print(response);
        }
        return right(converter(response.data));
      } else {
        return left(response.data['message']);
      }
    } on DioError catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      if (kDebugMode) {
        print(e);
      }
      return left(dioError['message']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left("");
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
