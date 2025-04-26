import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sire/controller/address/addaddresscontroller.dart';
import 'package:sire/view/widgets/address/gradientprogressindicator.dart';
import 'package:sire/view/widgets/address/searchmap.dart';

class AddAdress extends StatelessWidget {
  const AddAdress({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddAddressControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: SearchMap(),
      ),
      floatingActionButton: GetBuilder<AddAddressControllerImp>(
        builder: (controller) => IgnorePointer(
          ignoring: !controller.isUserLocationMarked,
          child: AnimatedScale(
            scale: controller.isUserLocationMarked ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              opacity: controller.isUserLocationMarked ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: FloatingActionButton(
                onPressed: () {
                  controller.goToAddMoreDetails();
                },
                tooltip: "proceed",
                child: controller.isDone
                    ? SizedBox(
                        height: 40,
                        width: 40,
                        child: GradientProgressIndicator(
                          strokeWidth: 5,
                        ))
                    : Icon(
                        Icons.add_location_alt,
                        size: 32,
                      ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GetBuilder<AddAddressControllerImp>(
        builder: (controller) => Stack(children: [
          SizedBox.expand(
            child: GoogleMap(
              compassEnabled: true,
              mapToolbarEnabled: false,
              mapType: controller.mapType,
              markers: controller.markers,
              onTap: (argument) {
                controller.addMarker(argument);
              },
              initialCameraPosition: controller.initialCameraPosition,
              onMapCreated: (GoogleMapController googleMapController) {
                controller.googleMapController!.complete(googleMapController);
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.small(
                  heroTag: 'location_fab',
                  onPressed: () {
                    controller.getUserLocation();
                  },
                  backgroundColor: Colors.white,
                  elevation: 2,
                  child: controller.loding
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: GradientProgressIndicator(
                            strokeWidth: 3,
                          ))
                      : Icon(
                          Icons.my_location,
                          color: Colors.pink[700],
                        ),
                ),
                SizedBox(height: 12),
                FloatingActionButton.small(
                  heroTag: 'maptype_fab',
                  onPressed: () {
                    controller.changeMapType();
                  },
                  backgroundColor: Colors.white,
                  elevation: 2,
                  child: Icon(
                    Icons.layers,
                    color: Colors.pink[700],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
