
import 'package:dio/dio.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import '../../../interceptor/http_interceptor.dart';
import '../model/especialista.dart';

class EspecialistaService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-doctors';

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<Especialista>> getPorProfissional() async {
    List<Especialista> result = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        //print(response.data);
        List data = response.data;
        for (dynamic registro in data) {
          result.add(Especialista.fromJson(registro));
        }
        return result;
      }
    } on DioError catch (e) {
      print(e);
    }

    return result;
  }

  
}
