import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sire/core/constant/approutes.dart';
import 'package:sire/core/middleware/myMiddleware.dart';
import 'package:sire/view/screens/OnBoarding.dart';
import 'package:sire/view/screens/home/homescreen.dart';
import 'package:sire/view/screens/items/ItemsView.dart';
import 'package:sire/view/screens/resetpassword/resetpassword.dart';
import 'package:sire/view/screens/resetpassword/forgotpassword.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:sire/view/screens/auth/signUp.dart';
import 'package:sire/view/screens/resetpassword/verifycode.dart';
import 'package:sire/view/screens/auth/verifycodesignup.dart';
import 'package:sire/view/screens/home/home.dart';
import 'package:sire/view/screens/items/itemdetails.dart';

List<GetPage<dynamic>>? route = [
  GetPage(name: "/", page: () => OnBoarding(), middlewares: [MyMiddleware()]),
  //auth
  GetPage(name: Approutes.login, page: () => Login()),
  GetPage(name: Approutes.signUp, page: () => SignUp()),
  GetPage(name: Approutes.forgot, page: () => ForgotPassword()),
  GetPage(name: Approutes.verify, page: () => VerifyCode()),
  GetPage(name: Approutes.rest, page: () => RestPassword()),
  GetPage(name: Approutes.verifyCodeSignUp, page: () => VerifyCodeSignUp()),
  //home
  GetPage(name: Approutes.home, page: () => Home()),
  GetPage(name: Approutes.homescreen, page: () => HomeScreen()),
  GetPage(name: Approutes.item, page: () => ItemsView()),
  GetPage(name: Approutes.itemDetails, page: () => ItemDetails()),
];
