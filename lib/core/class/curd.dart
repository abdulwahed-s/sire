import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
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
      print(e.toString());
      return left(StatusRequest.serverexception);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithImageOne(
      url, data, File? image,
      [String? namerequest]) async {
    namerequest ??= "files";

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(namerequest, stream, length,
          filename: basename(image.path));
      request.files.add(multipartFile);
    }

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // add Data to request
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithTwoImages(
      url, data, File? image1, File? image2,
      [String? namerequest1, String? namerequest2]) async {
    namerequest1 ??= "pfp";
    namerequest2 ??= "banner";

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);

    if (image1 != null) {
      var length = await image1.length();
      var stream = http.ByteStream(image1.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(namerequest1, stream, length,
          filename: basename(image1.path));
      request.files.add(multipartFile);
    }

    if (image2 != null) {
      var length = await image2.length();
      var stream = http.ByteStream(image2.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(namerequest2, stream, length,
          filename: basename(image2.path));
      request.files.add(multipartFile);
    }

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
