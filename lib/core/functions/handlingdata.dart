import 'package:sire/core/class/statusrequest.dart';

handlingdata(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
