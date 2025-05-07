import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/orders/orderdetailscontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/screens/address/updateadress.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailsControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Order Details',
            style: TextStyle(
                color: Appcolor.amaranthpink,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Appcolor.amaranthpink,
        ),
        elevation: 0,
      ),
      body: GetBuilder<OrderDetailsControllerImp>(builder: (controller) {
        if (controller.orderDetails.isEmpty) {
          return Center(
              child: CircularProgressIndicator(
            color: Appcolor.amaranthpink,
          ));
        }

        String getStatusText(int statusCode, int orderType) {
          switch (statusCode) {
            case 0:
              return 'Pending Approval';
            case 1:
              return 'Preparing';
            case -1:
              return 'Cancelled';
            case 5:
              return 'User Picked Up';
            case 6:
              return 'Archived';
          }

          if (orderType == 0) {
            switch (statusCode) {
              case 2:
                return 'On The Way';
              case 3:
                return 'Delivered';
            }
          } else {
            if (statusCode == 4) return 'Ready for Pickup';
          }

          return 'Unknown Status';
        }

        List<Map<String, dynamic>> getSteps(int orderType) {
          if (orderType == 0) {
            return [
              {'title': getStatusText(0, orderType), 'icon': Icons.access_time},
              {'title': getStatusText(1, orderType), 'icon': Icons.build},
              {
                'title': getStatusText(2, orderType),
                'icon': Icons.delivery_dining
              },
              {
                'title': getStatusText(3, orderType),
                'icon': Icons.check_circle
              },
              if (controller.orderDetails[0].orderStatus == 6)
                {'title': getStatusText(6, orderType), 'icon': Icons.archive},
            ];
          } else {
            return [
              {'title': getStatusText(0, orderType), 'icon': Icons.access_time},
              {'title': getStatusText(1, orderType), 'icon': Icons.restaurant},
              {'title': getStatusText(4, orderType), 'icon': Icons.store},
              {
                'title': getStatusText(5, orderType),
                'icon': Icons.check_circle
              },
              if (controller.orderDetails[0].orderStatus == 6)
                {'title': getStatusText(6, orderType), 'icon': Icons.archive},
            ];
          }
        }

        final int orderType = controller.orderDetails[0].orderType ?? 0;
        final List<Map<String, dynamic>> steps = getSteps(orderType);
        final int currentStatus = controller.orderDetails[0].orderStatus!;
        final isDelivery = orderType == 0;
        final isCancelled = currentStatus == -1;
        final isArchived = currentStatus == 6;

        final currentStepIndex = isDelivery
            ? currentStatus == 2
                ? 2
                : currentStatus == 3
                    ? 3
                    : currentStatus == 6
                        ? 4
                        : currentStatus >= 1
                            ? 1
                            : 0
            : currentStatus == 4
                ? 2
                : currentStatus == 5
                    ? 3
                    : currentStatus == 6
                        ? 4
                        : currentStatus >= 1
                            ? 1
                            : 0;

        final isCurrentStepCompleted =
            (isDelivery && (currentStatus == 3 || currentStatus == 6)) ||
                (!isDelivery && (currentStatus == 5 || currentStatus == 6));

        late final GlobalKey<GoogleMapState> mapKey;
        late final CameraPosition cameraPosition;
        late final Marker marker;

        if (orderType == 0) {
          mapKey = GlobalKey();
          cameraPosition = CameraPosition(
            target: LatLng(controller.orderDetails[0].addressLat ?? 0,
                controller.orderDetails[0].addressLong ?? 0),
            zoom: 14.4746,
          );
          marker = controller.parseMarkerFromString(controller
              .orderDetails[0].addressMarker!
              .replaceAll(RegExp(r'^{|}$'), ''));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ORDER #${controller.orderDetails[0].orderId!}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.amaranthpink,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                      controller.orderDetails[0].orderStatus!,
                                      orderType)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _getStatusColor(
                                    controller.orderDetails[0].orderStatus!,
                                    orderType),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              getStatusText(
                                  controller.orderDetails[0].orderStatus!,
                                  orderType),
                              style: TextStyle(
                                  color: _getStatusColor(
                                      controller.orderDetails[0].orderStatus!,
                                      orderType),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        title: Jiffy.parse(
                                controller.orderDetails[0].orderDatetime!)
                            .format(pattern: 'MMM dd, yyyy - hh:mm a'),
                        subtitle: Jiffy.parse(
                                controller.orderDetails[0].orderDatetime!)
                            .fromNow(),
                      ),
                      SizedBox(height: 12),
                      _buildInfoRow(
                        icon: orderType == 0
                            ? Icons.delivery_dining
                            : Icons.store,
                        title: orderType == 0 ? 'Delivery' : 'Pickup',
                        subtitle: orderType == 0
                            ? '${controller.orderDetails[0].orderPricedelivery}\$'
                            : 'Pickup at store',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildSectionHeader("Order Items"),
              SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.orderDetails.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 24,
                          color: Colors.grey[200],
                          thickness: 1,
                        ),
                        itemBuilder: (context, index) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  AppLink.itemimage +
                                      controller.orderDetails[index].itemImg!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[100],
                                    child: Icon(
                                      Icons.fastfood,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.orderDetails[index].itemName!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    controller.orderDetails[index].itemDesc!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Appcolor.amaranthpink
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: Appcolor.amaranthpink
                                                .withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          controller.orderDetails[index]
                                              .categoryName!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Appcolor.amaranthpink,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Price:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${controller.orderDetails[index].itemFinalPrice}\$",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Appcolor.amaranthpink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(height: 1, color: Colors.grey[200]),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Total:",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${controller.orderDetails[0].orderTotalprice}\$",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.amaranthpink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (orderType == 0) ...[
                _buildSectionHeader("Delivery Address"),
                SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Appcolor.amaranthpink.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: Appcolor.amaranthpink,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              controller.orderDetails[0].addressName!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  controller.orderDetails[0].addressBymap!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildAddressDetailRow("Building",
                                  controller.orderDetails[0].addressBuilding!),
                              _buildAddressDetailRow("Street",
                                  controller.orderDetails[0].addressStreet!),
                              _buildAddressDetailRow("Block",
                                  controller.orderDetails[0].addressBlock!),
                              _buildAddressDetailRow("Floor",
                                  controller.orderDetails[0].addressFloor!),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.grey[200]!, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GoogleMap(
                              key: mapKey,
                              zoomControlsEnabled: false,
                              zoomGesturesEnabled: false,
                              scrollGesturesEnabled: false,
                              mapToolbarEnabled: false,
                              tiltGesturesEnabled: false,
                              mapType: MapType.normal,
                              markers: {marker},
                              initialCameraPosition: cameraPosition,
                              onMapCreated:
                                  (GoogleMapController googleMapController) {
                                googleMapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                      cameraPosition),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
              if (orderType == 1) ...[
                _buildSectionHeader("Pickup Information"),
                SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Appcolor.amaranthpink.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.store,
                                color: Appcolor.amaranthpink,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Store Pickup",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "Please come to our store to pick up your order when it's ready",
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildAddressDetailRow("Pickup Time",
                                  "When order status is 'Ready for Pickup'"),
                              _buildAddressDetailRow(
                                  "Location", "123 Main Street, City Center"),
                              _buildAddressDetailRow(
                                  "Contact", "+123 456 7890"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
              _buildSectionHeader("Order Status"),
              SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: steps.length,
                          itemBuilder: (context, idx) {
                            final step = steps[idx];
                            final isCompleted = idx < currentStepIndex ||
                                (idx == currentStepIndex &&
                                    isCurrentStepCompleted);
                            final isLast = idx == steps.length - 1;
                            final isCurrent = idx == currentStepIndex;

                            return Container(
                              width: 120,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isCancelled || isArchived
                                              ? Colors.grey[300]
                                              : isCompleted
                                                  ? Appcolor.amaranthpink
                                                  : Colors.grey[200],
                                          border: Border.all(
                                            color: isCancelled || isArchived
                                                ? Colors.grey
                                                : isCompleted
                                                    ? Appcolor.amaranthpink
                                                    : Colors.grey[300]!,
                                            width: 2,
                                          ),
                                        ),
                                        child: isCancelled
                                            ? Icon(Icons.close,
                                                size: 20, color: Colors.white)
                                            : isArchived
                                                ? Icon(Icons.archive,
                                                    size: 20,
                                                    color: Colors.white)
                                                : Icon(step['icon'],
                                                    size: 20,
                                                    color: isCompleted
                                                        ? Colors.white
                                                        : isCurrent
                                                            ? Appcolor
                                                                .amaranthpink
                                                            : Colors.grey[500]),
                                      ),
                                      if (isCurrent &&
                                          !isCancelled &&
                                          !isArchived)
                                        Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Appcolor.amaranthpink
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    step['title']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: isCancelled || isArchived
                                          ? Colors.grey
                                          : isCompleted
                                              ? Colors.black
                                              : Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    (isCancelled
                                        ? "Cancelled"
                                        : isArchived
                                            ? "Archived"
                                            : isCurrent
                                                ? isCurrentStepCompleted
                                                    ? "Completed"
                                                    : "In Progress"
                                                : isCompleted
                                                    ? "Completed"
                                                    : "Pending"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isCancelled || isArchived
                                          ? Colors.grey
                                          : isCompleted
                                              ? Appcolor.amaranthpink
                                              : Colors.grey[400],
                                    ),
                                  ),
                                  if (!isLast)
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          width: 40,
                                          height: 2,
                                          color: isCancelled || isArchived
                                              ? Colors.grey[300]
                                              : idx < currentStepIndex ||
                                                      (idx == currentStepIndex &&
                                                          isCurrentStepCompleted)
                                                  ? Appcolor.amaranthpink
                                                  : Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildHelpOption(Icons.headset_mic, "Contact Support",
                          "Get help with your order", () {}),
                      Divider(height: 24, color: Colors.grey[200]),
                      _buildHelpOption(Icons.replay, "Report an Issue",
                          "Having problems with your order?", () {}),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Appcolor.amaranthpink.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Appcolor.amaranthpink,
            size: 18,
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildAddressDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Appcolor.amaranthpink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Appcolor.amaranthpink,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int status, int orderType) {
    if (status == -1) return Colors.grey;
    if (status == 6) return Colors.grey.shade600;

    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 5:
        return orderType == 1 ? Colors.green : Colors.grey.shade600;
    }

    if (orderType == 0) {
      switch (status) {
        case 2:
          return Colors.purple;
        case 3:
          return Colors.green;
      }
    } else {
      if (status == 4) return Colors.teal;
    }

    return Colors.grey;
  }
}
