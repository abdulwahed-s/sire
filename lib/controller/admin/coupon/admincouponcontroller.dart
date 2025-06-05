import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/admin/admindata.dart';
import 'package:sire/data/model/couponmodel.dart';
import 'package:sire/view/screens/admin/coupon/editcoupon.dart';

abstract class AdminCouponController extends GetxController {
  getCoupons();
  goToEditCoupon(CouponModel couponModel);
  bool isExpired(String? expiryDate);
  String formatDate(String? date);
}

class AdminCouponControllerImp extends AdminCouponController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<CouponModel> coupons = [];

  @override
  getCoupons() async {
    statusRequest = StatusRequest.loding;
    coupons.clear();
    var response = await adminData.getCoupons();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        print(data);
        coupons.addAll(data.map((e) => CouponModel.fromJson(e)));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getCoupons();
    super.onInit();
  }

  @override
  goToEditCoupon(couponModel) {
    Get.to(
      () => EditCoupon(),
      arguments: {"couponModel": couponModel},
    );
  }

  @override
  bool isExpired(String? expiryDate) {
    if (expiryDate == null) return false;
    try {
      final expiry = DateTime.parse(expiryDate);
      return expiry.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  @override
  String formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }
}
