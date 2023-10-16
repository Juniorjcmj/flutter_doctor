import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:flutter_doctor/modulos/livroCaixa/state/livro_caixa_controller.dart';
import 'package:flutter_doctor/shared/state/splash_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../../../interceptor/http_interceptor.dart';

class LivroCaixaService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-livro-caixa';
  static final LivroCaixaController livroController = Get.put(LivroCaixaController()); 
  static final SplashController loaderController = Get.put(SplashController());

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<LivroCaixa>> getLivroCaixas() async {
    loaderController.isLoader.value = true;
    // ignore: non_constant_identifier_names
    List<LivroCaixa> LivroCaixas = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          LivroCaixas.add(LivroCaixa.fromMap(registro));
        }
        loaderController.isLoader.value = false;
        return LivroCaixas;
      }
    } on DioError catch (e) {
      loaderController.isLoader.value = false;
      log(e.message);
    }
   loaderController.isLoader.value = false;
    return LivroCaixas;
  }

  static Future<Map<String, dynamic>> cadastrarLivroCaixa(
      Map<String, dynamic> dados) async {
    Response response;
    final Map<String, dynamic> data = {};
    int id = dados['id'];
    try {
      if (dados['id'] != null) {
        response = await _dio.put(
          '$apiUrl/$id',
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

         if(response.data['tipoMovimentacao'] == 'RECEITA'){
          livroController.adicionarReceita(response.data['valor']);
         }else{
          livroController.adicionarDespesa(response.data['valor']);
         }
       
         livroController.listConta.value.asMap().forEach((index, conta) {

        if (conta.id == response.data['idContacorrente']) {         
          conta.saldo = response.data['saldo'];
          livroController.atualizarConta(index, conta);
        }
      });
         


        return data;
      } else {
        data.addAll({'status': false, 'livroCaixa': LivroCaixa()});
        return data;
      }
    } catch (error) {
       data.addAll({'status': false, 'livroCaixa': LivroCaixa()});
       return data;
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
   loaderController.atualizarLoader(true);
   livroController.zerarValores();

    List<LivroCaixa> livroCaixas = [];
    Response response;

    try {
      response = await _dio.post(
        '$apiUrl/filtro-periodo',
        data: dados,
      );

      if (response.statusCode == 200) {
         loaderController.atualizarLoader(false);
        List data = response.data;
        for (dynamic registro in data) {
          LivroCaixa livro = LivroCaixa.fromMap(registro);
          livroCaixas.add(livro);

          if(livro.tipoMovimentacao == "RECEITA"){
            livroController.adicionarReceita(livro.valor!);
          }else{
             livroController.adicionarDespesa(livro.valor!);
             if(livro.classificacao == "FIXA"){
              livroController.adicionarFixa(livro.valor!);
             }else{
              livroController.adicionarVariavel(livro.valor!);
             }

          }
        }
      }
      loaderController.atualizarLoader(false);
      livroController.list.value = livroCaixas;
      return livroCaixas;
    } on DioError catch (e) {
      log(e.message);
    }
    return livroCaixas;
  }
}
