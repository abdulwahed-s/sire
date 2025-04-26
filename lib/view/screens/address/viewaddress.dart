import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sire/controller/address/viewaddreesscontroller.dart';
import 'package:sire/core/class/handlingdataview.dart';
import 'package:sire/core/constant/color.dart';

class ViewAddress extends StatelessWidget {
  const ViewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    ViewAddressControllerImp controller = Get.put(ViewAddressControllerImp());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Appcolor.white,
          title: Text(
            "Delevery Address",
            style: TextStyle(color: Appcolor.pink),
          ),
        ),
        bottomNavigationBar: Material(
          color: Appcolor.amaranthpink,
          child: InkWell(
            onTap: () {
              controller.goToAddAddress();
            },
            splashColor: Appcolor.berry,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(),
              child: Text(
                "Add New Address",
                style: TextStyle(
                    // color: Appcolor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: GetBuilder<ViewAddressControllerImp>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: controller.addresses.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.addresses.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  endIndent: 10,
                                  indent: 10,
                                  height: 1,
                                  color: Appcolor.berry.withValues(alpha: 0.4),
                                ),
                                Slidable(
                                    endActionPane: ActionPane(
                                        motion: ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            flex: 2,
                                            onPressed: (context) {
                                              controller.goToUpdate(
                                                  controller.addresses[index]);
                                            },
                                            backgroundColor: Appcolor.deepcyan,
                                            foregroundColor: Colors.white,
                                            icon: Icons.edit_rounded,
                                            label: 'Update',
                                          ),
                                          SlidableAction(
                                            flex: 2,
                                            onPressed: (context) {
                                              controller.deleteAddress(
                                                  controller.addresses[index]
                                                      .addressId!);
                                            },
                                            backgroundColor:
                                                Appcolor.amaranthpink,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete_rounded,
                                            label: 'Delete',
                                          ),
                                        ]),
                                    child: ListTile(
                                      title: Text(controller
                                          .addresses[index].addressName!),
                                      subtitle: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: controller.addresses[index]
                                                  .addressBymap!,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " Building: ${controller.addresses[index].addressBuilding!}, "
                                                  "Street: ${controller.addresses[index].addressStreet!}, "
                                                  "Block: ${controller.addresses[index].addressBlock!}, "
                                                  "Floor: ${controller.addresses[index].addressFloor!}.",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    )),
                                Divider(
                                  endIndent: 10,
                                  indent: 10,
                                  height: 1,
                                  color: Appcolor.berry.withValues(alpha: 0.4),
                                ),
                              ],
                            );
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Appcolor.amaranthpink,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Your address book is empty",
                                style: TextStyle(
                                  color: Appcolor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Add your delivery address to help us deliver your orders",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                )));
  }
}
