import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class FavouritesData {
  Curd curd;
  FavouritesData(this.curd);
  favouritesAdd(String userId, String itemId) async {
    var resp = await curd.postData(AppLink.favouritesAdd, {
      "userId": userId,
      "itemId": itemId,
    });
    return resp.fold((s) => s, (r) => r);
  }

  favouritesDelete(String userId, String itemId) async {
    var resp = await curd.postData(AppLink.favouritesDelete, {
      "userId": userId,
      "itemId": itemId,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
