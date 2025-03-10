import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class Curd {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkinternet()) {
        var response = await http.post(Uri.parse(linkurl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return right(responseBody);
        } else {
          return left(StatusRequest.serverfailure);
        }
      }
      {
        return left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return left(StatusRequest.serverexception);
    }
  }
}
