
import 'package:get/get.dart';

class SplashController extends GetxController{

  var isLoader = false.obs;

  void atualizarLoader(bool valor){
    isLoader.value = valor;
    update();

  }
  
}