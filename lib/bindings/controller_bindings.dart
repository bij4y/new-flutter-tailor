import 'package:get/get.dart';
import 'package:newtailor/controller/carousel_controller.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/controller/invoice_controller.dart';
import 'package:newtailor/controller/onboarding_controller.dart';
import 'package:newtailor/controller/product_controller.dart';
import 'package:newtailor/controller/search_controller.dart';
import 'package:newtailor/controller/tailorcontroller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(SearchController());
    Get.put(OnboardingController());
    Get.put(TailorController());
    Get.put(CarouselController());
    Get.put(InvoiceController());
  }
}
