import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/controller/notification/notificationcontroller.dart';
import 'package:sire/core/constant/color.dart';

class ViewNotification extends StatelessWidget {
  const ViewNotification({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 1,
      ),
      body: GetBuilder<NotificationControllerImp>(
        builder: (controller) {
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
