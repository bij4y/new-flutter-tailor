import 'package:get/get.dart';
import 'package:newtailor/model/carousel_model.dart';
import 'package:newtailor/services/service.dart';

class CarouselController extends GetxController {
  var carousel = CarouselModel(data: []).obs;

  var isLoading = true.obs;

  Future carouselData() async {
    try {
      isLoading(true);

      var response = await RemoteService().carousel();
      if (response != null) {
        carousel.value = response;
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    carouselData();
  }
}
