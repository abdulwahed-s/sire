import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/imageasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    Widget displayedWidget;

    switch (statusRequest) {
      case StatusRequest.loding:
        displayedWidget = Center(child: Lottie.asset(AppImage.loading));
        break;
      case StatusRequest.offlinefailure:
        displayedWidget = Center(child: Lottie.asset(AppImage.offline));
        break;
      case StatusRequest.serverfailure:
        displayedWidget = Center(child: Lottie.asset(AppImage.e404));
        break;
      case StatusRequest.failure:
        displayedWidget = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(AppImage.nodata),
              Text(
                "No Data",
                style: TextStyle(
                  fontFamily: 'Sw',
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        );
        break;
      default:
        displayedWidget = widget;
    }

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: displayedWidget,
      ),
    );
  }
}
