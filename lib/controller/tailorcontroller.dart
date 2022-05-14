import 'package:get/get.dart';
import 'package:newtailor/model/product_model.dart';
import 'package:newtailor/model/tailormodel.dart';
import 'package:newtailor/services/service.dart';

class TailorController extends GetxController {
  // var advice = {}.obs;
  var tailorlist = TailorModel(data: []).obs;
  var products = ProductModel(data: []).obs;
  // var productlist = <Product>[].obs;

  var isLoading = true.obs;

  Future fetchData() async {
    try {
      isLoading(true);

      var response = await RemoteService().fetchTailorData();
      if (response != null) {
        tailorlist.value = response;
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future fetchProduct(int id) async {
    try {
      isLoading(true);

      var response = await RemoteService().fetchTailorDetail(id);
      if (response != null) {
        products.value = response;
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
    fetchData();
  }
}
