import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/address/addressdata.dart';
import 'package:sire/data/model/addressmodel.dart';
import 'package:sire/view/screens/address/updateadressmap.dart';
import 'package:sire/view/screens/address/viewaddress.dart';
import 'package:sire/view/screens/settings/settings.dart';

abstract class UpdateAddressController extends GetxController {
  goToMap();
  updateData();
}

class UpdateAddressControllerImp extends UpdateAddressController {
  final Services services = Get.find<Services>();
  AddressModel? addressMode;

  double? lat;
  double? long;
  String? placeName;
  Set<Marker>? markers;
  bool isMapUpdated = false;

  late GlobalKey<FormState> formkey;

  late TextEditingController addressName;
  late TextEditingController buildingName;
  late TextEditingController aptNumber;
  late TextEditingController floor;
  late TextEditingController street;
  late TextEditingController block;
  late TextEditingController way;
  late TextEditingController additionalDetails;

  final AddressData addressData = AddressData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    formkey = GlobalKey<FormState>();
    addressMode = Get.arguments["addressMode"];

  
    addressName = TextEditingController();
    buildingName = TextEditingController();
    aptNumber = TextEditingController();
    floor = TextEditingController();
    street = TextEditingController();
    block = TextEditingController();
    way = TextEditingController();
    additionalDetails = TextEditingController();

   
    addressName.text = addressMode!.addressName ?? '';
    buildingName.text = addressMode!.addressBuilding ?? '';
    aptNumber.text = addressMode!.addressApt ?? '';
    floor.text = addressMode!.addressFloor ?? '';
    street.text = addressMode!.addressStreet ?? '';
    block.text = addressMode!.addressBlock ?? '';
    way.text = addressMode!.addressWay ?? '';
    additionalDetails.text = addressMode!.addressAdditional ?? '';


    isMapUpdated = Get.arguments["isMapUpdated"] ?? false;

    if (!isMapUpdated) {
  
      placeName = addressMode!.addressBymap;
      if (addressMode!.addressMarker != null) {
        try {
          Marker marker = parseMarkerFromString(
              addressMode!.addressMarker!.replaceAll(RegExp(r'^{|}$'), ''));
          markers = {marker};
        } catch (e) {
          markers = {};
        }
      } else {
        markers = {};
      }
      lat = addressMode!.addressLat;
      long = addressMode!.addressLong;
    } else {
     
      placeName = Get.arguments["newplacename"] ?? addressMode!.addressBymap;
      markers = Get.arguments["newmarker"] ?? {};
      lat = Get.arguments["newlat"] ?? addressMode!.addressLat;
      long = Get.arguments["newlong"] ?? addressMode!.addressLong;
    }

    super.onInit();
  }

  @override
  void dispose() {
    addressName.dispose();
    buildingName.dispose();
    aptNumber.dispose();
    floor.dispose();
    street.dispose();
    block.dispose();
    way.dispose();
    additionalDetails.dispose();
    super.dispose();
  }

  @override
  updateData() async {
    if (formkey.currentState?.validate() ?? false) {
      if (lat == null || long == null) {
        Get.snackbar("Error", "Please select a location on the map");
        return;
      }

      statusRequest = StatusRequest.loding;
      update();

      try {
        var response = await addressData.updateAddress(
          addressMode!.addressId.toString(),
          addressName.text,
          buildingName.text,
          aptNumber.text,
          floor.text,
          street.text,
          block.text,
          way.text,
          additionalDetails.text,
          placeName ?? "Unknown Location",
          markers.toString(),
          lat!.toString(),
          long!.toString(),
        );

        statusRequest = handlingdata(response);
        update();

        if (statusRequest == StatusRequest.success) {
          if (response["status"] == "success") {
            Get.offAll(() => Settings(), transition: Transition.fade);
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.to(() => ViewAddress(), transition: Transition.fade);
            });
          } else {
            Get.snackbar("Error", "Failed to update address");
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        statusRequest = StatusRequest.serverfailure;
        Get.snackbar("Error", "An error occurred while updating address");
        update();
      }
    }
  }

  Marker parseMarkerFromString(String markerString) {
    try {
   
      final latLngMatch =
          RegExp(r'LatLng\(([0-9.]+), ([0-9.]+)\)').firstMatch(markerString);
      if (latLngMatch == null) {
        throw const FormatException("Invalid LatLng in marker string");
      }

      final double lat = double.parse(latLngMatch.group(1)!);
      final double lng = double.parse(latLngMatch.group(2)!);
      final LatLng position = LatLng(lat, lng);

    
      final markerIdMatch =
          RegExp(r'MarkerId\(([0-9]+)\)').firstMatch(markerString);
      final String markerId = markerIdMatch?.group(1) ?? '1';

      return Marker(
        markerId: MarkerId(markerId),
        position: position,
        alpha: 1.0,
        anchor: const Offset(0.5, 1.0),
        consumeTapEvents: false,
        draggable: false,
        infoWindow: const InfoWindow(title: null, snippet: null),
        visible: true,
      );
    } catch (e) {
    
      return const Marker(
        markerId: MarkerId('1'),
        position: LatLng(0, 0),
      );
    }
  }

 
  void updateMapLocation(double newLat, double newLong, String newPlaceName,
      Set<Marker> newMarkers) {
    lat = newLat;
    long = newLong;
    placeName = newPlaceName;
    markers = newMarkers;
    isMapUpdated = true;
    update(); 
  }

  @override
  goToMap() {
    Get.to(() => UpdateAddressMap(), arguments: {
      "oldlat": lat ?? addressMode?.addressLat,
      "oldlong": long ?? addressMode?.addressLong,
      "oldmarker": markers ?? {},
    });
  }
  
  
}
