import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/address/addressdata.dart';
import 'package:sire/view/screens/address/viewaddress.dart';
import 'package:sire/view/screens/settings/settings.dart';

abstract class AddMoreDetailsController extends GetxController {}

class AddMoreDetailsControllerImp extends AddMoreDetailsController {
  Services services = Get.find<Services>();

  double? lat;
  double? long;
  String? placeName;
  Set<Marker>? markers;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController? addressName;
  TextEditingController? buildingName;
  TextEditingController? aptNumber;
  TextEditingController? floor;
  TextEditingController? street;
  TextEditingController? block;
  TextEditingController? way;
  TextEditingController? additionalDetails;

  AddressData addressData = AddressData(Get.find());
  late StatusRequest statusRequest;

  @override
  void onInit() {
    lat = Get.arguments["latitude"];
    long = Get.arguments["longitude"];
    placeName = Get.arguments["placeName"];
    markers = Get.arguments["markers"];

    addressName = TextEditingController();
    buildingName = TextEditingController();
    aptNumber = TextEditingController();
    floor = TextEditingController();
    street = TextEditingController();
    block = TextEditingController();
    way = TextEditingController();
    additionalDetails = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    addressName!.dispose();
    buildingName!.dispose();
    aptNumber!.dispose();
    floor!.dispose();
    street!.dispose();
    block!.dispose();
    way!.dispose();
    additionalDetails!.dispose();
    super.dispose();
  }

  sendData() async {
    var fomrstate = formkey.currentState;
    if (fomrstate!.validate()) {
      statusRequest = StatusRequest.loding;
      update();
      var response = await addressData.addAddress(
        services.sharedPreferences.getString("id")!,
        addressName!.text,
        buildingName!.text,
        aptNumber!.text,
        floor!.text,
        street!.text,
        block!.text,
        way?.text ?? "",
        additionalDetails?.text ?? "",
        placeName ?? "Unknown Location",
        markers.toString(),
        lat!.toString(),
        long!.toString(),
      );
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.offAll(() => Settings(), transition: Transition.fade);
          Future.delayed(Duration(milliseconds: 100), () {
            Get.to(() => ViewAddress(), transition: Transition.fade);
          });
        } else if (response["status"] == "failure") {
          statusRequest = StatusRequest.failure;
        }
      }
    }
  }
}
