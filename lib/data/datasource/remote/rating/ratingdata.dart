import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class RatingData {
  Curd curd;
  RatingData(this.curd);
  addRating(String userid, String itemid, String stars, String comment) async {
    var resp = await curd.postData(AppLink.addRating, {
      "userid": userid,
      "itemid": itemid,
      "stars": stars,
      "comment": comment,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getRating(String itemid) async {
    var resp = await curd.postData(AppLink.getRating, {
      "itemid": itemid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  isOrdered(String userid, String itemid) async {
    var resp = await curd.postData(AppLink.getIsOrdered, {
      "userid": userid,
      "itemid": itemid,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
