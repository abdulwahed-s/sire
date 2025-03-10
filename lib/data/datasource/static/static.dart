import 'package:get/get.dart';
import 'package:sire/core/constant/imageasset.dart';
import 'package:sire/data/model/onBoardingmodel.dart';

List<OnBoardingModel> getOnBoardingList() {
  return [
    OnBoardingModel(title: '3'.tr, content: '4'.tr, image: AppImage.onBoardingImageone),
    OnBoardingModel(title: '5'.tr, content: '6'.tr, image: AppImage.onBoardingImagetwo),
    OnBoardingModel(title: '7'.tr, content: '8'.tr, image: AppImage.onBoardingImagethree),
    OnBoardingModel(title: '9'.tr, content: '10'.tr, image: AppImage.onBoardingImagefour),
  ];
}
