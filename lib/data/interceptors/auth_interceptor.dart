import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final GetStorage storage = GetStorage();
    String? token = storage.read('token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
