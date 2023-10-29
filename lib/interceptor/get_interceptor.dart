// import 'package:dio/dio.dart';
// import 'package:flutter_doctor/shared/service/local_storage_service.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';

// class GetxInterceptor implements Interceptor {

//    String _token = '';

//   GetxInterceptor() {
//     Get.find<LocalStorageService>().getToken().then((token) {
//       _token = token as String;
//     });
//   }

//   Future<Response> intercept(Request request) async {
//     request.headers['Authorization'] = 'Bearer $_token';
//     return await Get.httpClient().send(request);
//   }
  
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     // TODO: implement onError
//   }
  
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // TODO: implement onRequest
//   }
  
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     // TODO: implement onResponse
//   }
// }

