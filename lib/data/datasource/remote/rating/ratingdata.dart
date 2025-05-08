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
}
