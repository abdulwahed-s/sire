import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sire/controller/notification/notificationcontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';

class ViewNotification extends StatelessWidget {
  final bool visableAppBar;
  const ViewNotification({super.key, this.visableAppBar = true});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationControllerImp());
    return Scaffold(
      appBar: visableAppBar
          ? AppBar(
              title: Text('Notifications',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 1,
            )
          : null,
      body: GetBuilder<NotificationControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loding) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getNotification();
              },
              child: SingleChildScrollView(
                  physics:
                      AlwaysScrollableScrollPhysics(), // to allow pull-to-refresh
                  child: Column(
                    children: List.generate(
                      5,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Shimmer for the icon
                                Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey, // Placeholder color
                                    shape: BoxShape.circle,
                                  ),
                                  width: 48, // Match your icon container size
                                  height: 48,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Shimmer for title and time
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 20,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            width: 50,
                                            height: 12,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      // Shimmer for content
                                      Container(
                                        height: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        height: 16,
                                        width: double.infinity,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            );
          }

          if (controller.allNotification.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getNotification();
              },
              child: SingleChildScrollView(
                physics:
                    AlwaysScrollableScrollPhysics(), // to allow pull-to-refresh
                child: Container(
                  height: Get.height - 150,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none,
                          size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'No notifications yet',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              controller.getNotification();
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: controller.allNotification.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, indent: 72),
              itemBuilder: (context, index) {
                final notification = controller.allNotification[index];
                return Dismissible(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Appcolor.lightRed,
                    ),
                    child: Icon(
                      Icons.delete_rounded,
                      color: Appcolor.deepRed,
                    ),
                  ),
                  onDismissed: (direction) {
                    controller.deleteNotification(
                        controller.allNotification[index].notificationId
                            .toString(),
                        index);
                  },
                  key: UniqueKey(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Appcolor.amaranthpink.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.notifications,
                              color: Theme.of(context).primaryColor),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification.notificationTitle ??
                                          'No title',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    Jiffy.parse(
                                            notification.notificationDatetime ??
                                                DateTime.now().toString())
                                        .fromNow(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.notificationBody ?? 'No content',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
