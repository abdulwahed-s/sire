import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class ViewFavouritesData {
  Curd curd;
  ViewFavouritesData(this.curd);
  viewFavouritesData(
    String userId,
  ) async {
    var resp = await curd.postData(AppLink.favouritesView, {
      "id": userId,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
