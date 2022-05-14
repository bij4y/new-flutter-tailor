import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/view/bottomnavigation.dart';
import '../model/onboarding_info.dart';

class OnboardingController extends GetxController {
  var cartcontroller = Get.find<CartController>();
  var selectedPageIndex = 0.obs;
  var pageController = PageController();
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;

  forwardAction() {
    if (isLastPage) {
      // cartcontroller.getCartData();
      Get.off(() => const BottomNavigatorScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo("images/images.jpg", "Order Your Fashion",
        "Now you can order stitch any time right from your mobile"),
    OnboardingInfo("images/j.jpg", "Order Your Fashion",
        "Now you can order stitch any time right from your mobile"),
    OnboardingInfo("images/i.jpg", "Order Your Fashion",
        "Now you can order stitch any time right from your mobile"),
  ];
}
