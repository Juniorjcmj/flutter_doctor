import 'package:dio/dio.dart';

import '../services/local_storage_service.dart';

class DioInterceptor {
 final Dio _dio = Dio();

  DioInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
       String? token = await LocalStorageService().getToken();

              options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options); // Continua com a requisição
      },
    ));
  }
    
  Dio get dioInstance => _dio;
}