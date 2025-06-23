import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sire/core/constant/approutes.dart';
import 'package:sire/core/middleware/myMiddleware.dart';
import 'package:sire/view/screens/OnBoarding.dart';
import 'package:sire/view/screens/admin/adminhome.dart';
import 'package:sire/view/screens/delivery/deliveryhome.dart';
import 'package:sire/view/screens/delivery/deliveryrequests.dart';
import 'package:sire/view/screens/home/homescreen.dart';
import 'package:sire/view/screens/items/ItemsView.dart';
import 'package:sire/view/screens/items/viewFavourite.dart';
import 'package:sire/view/screens/resetpassword/resetpassword.dart';
import 'package:sire/view/screens/resetpassword/forgotpassword.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:sire/view/screens/auth/signUp.dart';
import 'package:sire/view/screens/resetpassword/verifycode.dart';
import 'package:sire/view/screens/auth/verifycodesignup.dart';
import 'package:sire/view/screens/home/home.dart';
import 'package:sire/view/screens/items/itemdetails.dart';
import 'package:sire/view/screens/settings/settings.dart';

List<GetPage<dynamic>>? route = [
  GetPage(name: "/", page: () => const OnBoarding(), middlewares: [MyMiddleware()]),

  //auth
  GetPage(name: Approutes.login, page: () => const Login()),
  GetPage(name: Approutes.signUp, page: () => const SignUp()),
  GetPage(name: Approutes.forgot, page: () => const ForgotPassword()),
  GetPage(name: Approutes.verify, page: () => const VerifyCode()),
  GetPage(name: Approutes.rest, page: () => const RestPassword()),
  GetPage(name: Approutes.verifyCodeSignUp, page: () => const VerifyCodeSignUp()),
  //home
  GetPage(name: Approutes.home, page: () => const Home()),
  GetPage(name: Approutes.homescreen, page: () => const HomeScreen()),
  GetPage(name: Approutes.item, page: () => const ItemsView()),
  GetPage(name: Approutes.itemDetails, page: () => const ItemDetails()),
  GetPage(name: Approutes.viewFavourite, page: () => const ViewFavourite()),
  //setting
  GetPage(name: Approutes.settings, page: () => const Settings()),
  //delivery
  GetPage(name: Approutes.deliveryRequests, page: () => const DeliveryRequests()),
  GetPage(name: Approutes.deliveryHome, page: () => const DeliveryHome()),
  GetPage(name: Approutes.adminHome, page: ()=> const AdminHome())
];
