import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class CheckoutData {
  Curd curd;
  CheckoutData(this.curd);
  placeOrder(
    String userID,
    String addressID,
    String type,
    String price,
    String pricedelivery,
    String paymenttype,
    String couponID,
  ) async {
    var resp = await curd.postData(AppLink.checkout, {
      'userid': userID,
      'ordaddressiderid': addressID,
      'type': type,
      'price': price,
      'paymenttype': paymenttype,
      'coupon': couponID,
      'deliveryprice': pricedelivery,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
