import "package:dio/dio.dart";
import '../../local_resource/data_store.dart';

class ClientInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) {
    options.headers = {
//      "Accept-Language": DataStore.instance.lang,
      // "Content-Type": Headers.jsonContentType,
      // "Content-Type":"text/html",
      "Authorization": "Bearer 191|Zybr7Q9AhFDTWVI60mmRNN6Vjv6AGEXumBcu9DsY",
      // "Accept": Headers.jsonContentType,
      "Accept": '*/*',
      // "AcceptApplication/json": Headers.jsonContentType,
    };
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data == "error") {
      handler.reject(
        DioError(
          requestOptions: response.requestOptions,
          response: response,
          error: response.data["msg"] ?? response.data["message"],
          type: DioErrorType.badResponse,
        ),
      );
    } else {
      handler.resolve(response);
    }
  }
}
