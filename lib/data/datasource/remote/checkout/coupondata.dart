import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class CouponData {
  Curd curd;
  CouponData(this.curd);
  checkCoupon(String coupon) async {
    var resp = await curd.postData(AppLink.checkCoupon, {
      "coupon": coupon,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
