import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/test.dart';

class Testcont extends GetxController {
  TestData testData = TestData(Get.find());

  List data = [];

  late StatusRequest statusRequest;
  getData() async {
    statusRequest = StatusRequest.loding;
    var response = await testData.getData();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
    if(response["status"]=="success"){
      data.addAll(response['data']);
    }else if(response["status"]=="failure"){
    statusRequest = StatusRequest.failure;
    }
    }
    update();
  }

  @override
  void onInit() {
  
    getData();
    super.onInit();
  }
}
