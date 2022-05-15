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
    OnboardingInfo("images/onboarding1.jpg", "Order Your Fashion",
        "A big Wellcome to your experience in Idris. Now you can order stitch any time right from your mobile."),
    OnboardingInfo("images/onboarding2.jpg", "Order Your Fashion",
        "We use advanced technology to provide you with the fit of a lifetime. It's time to leave unflattering off-the-rack sizes behind and join a personalized future."),
    OnboardingInfo("images/onboarding3.jpg", "Order Your Fashion",
        "It's time you start wearing high-quality clothes made only for you."),
  ];
}
