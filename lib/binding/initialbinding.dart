import 'package:get/get.dart';
import 'package:sire/core/class/curd.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
  Get.put(Curd());
  }
}