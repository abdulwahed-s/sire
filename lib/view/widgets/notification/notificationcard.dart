import 'package:flutter/material.dart';
import 'package:sire/controller/notification/notificationcontroller.dart';
import 'package:sire/view/widgets/notification/notificationcontent.dart';
import 'package:sire/view/widgets/notification/notificationicon.dart';

class NotificationCard extends StatelessWidget {
  final dynamic notification;
  final NotificationControllerImp controller;
  final int index;
  const NotificationCard(
      {super.key,
      this.notification,
      required this.controller,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_rounded,
              color: Colors.red[600],
              size: 20,
            ),
          ),
        ),
        onDismissed: (direction) {
          controller.deleteNotification(
            controller.allNotification[index].notificationId.toString(),
            index,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // Handle notification tap
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NotificationIcon(notification: notification),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NotificationContent(
                          notification: notification,
                          controller: controller,
                          index: index),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
