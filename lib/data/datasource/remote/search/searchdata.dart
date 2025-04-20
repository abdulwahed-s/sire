import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class SearchData {
  Curd curd;
  SearchData(this.curd);
  search(String searchItem) async {
    var resp = await curd.postData(AppLink.search, {
      "searchitem": searchItem,
    });
    return resp.fold((s) => s, (r) => r);
  }

  suggestion() async {
    var resp = await curd.postData(AppLink.suggestion, {});
    return resp.fold((s) => s, (r) => r);
  }
}
