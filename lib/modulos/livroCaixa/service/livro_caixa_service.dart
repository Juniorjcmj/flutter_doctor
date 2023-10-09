import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import '../../../interceptor/http_interceptor.dart';

class LivroCaixaService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-LivroCaixa';

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<LivroCaixa>> getLivroCaixas() async {
    List<LivroCaixa> LivroCaixas = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          LivroCaixas.add(LivroCaixa.fromMap(registro));
        }
        return LivroCaixas;
      }
    } on DioError catch (e) {
      log(e.message);
    }

    return LivroCaixas;
  }

  static Future<Map<String, dynamic>> cadastrarLivroCaixa(
      Map<String, dynamic> dados) async {
    Response response;
    final Map<String, dynamic> data = {};
    try {
      if (dados['id'] != null) {
        response = await _dio.put(
          '$apiUrl/'+dados['id'].toString(),
          data: dados,
        );
      } else {
        response = await _dio.post(
          apiUrl,
          data: dados,
        );
      }

      if (response.statusCode == 200) {
        data.addAll(
            {'status': true, 'livroCaixa': LivroCaixa.fromMap(response.data)});
        return data;
      } else {
        data.addAll({'status': false, 'livroCaixa': LivroCaixa()});
        return data;
      }
    } catch (error) {
      throw ArgumentError.value(error);
    }
  }

  static Future<bool> deletar(String id) async {
    Response response = await _dio.delete('$apiUrl/$id');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<LivroCaixa> findById(String id) async {
    var livroCaixa = LivroCaixa();
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {
        livroCaixa = LivroCaixa.fromMap(response.data);
        return livroCaixa;
      }
    } on DioError catch (e) {
      log(e.message);
    }

    return livroCaixa;
  }

  static Future<List<LivroCaixa>> filtroAvancado(
      Map<String, dynamic> dados) async {
    List<LivroCaixa> livroCaixas = [];
    Response response;

    try {
      response = await _dio.post(
        '$apiUrl/filtro',
        data: dados,
      );

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          livroCaixas.add(LivroCaixa.fromMap(registro));
        }
      }
      return livroCaixas;
    } on DioError catch (e) {
      log(e.message);
    }
    return livroCaixas;
  }
}
