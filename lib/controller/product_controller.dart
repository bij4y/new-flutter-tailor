import 'package:get/get.dart';
import 'package:newtailor/model/product_model.dart';
import 'package:newtailor/model/stitch_productmodel.dart';
import 'package:newtailor/services/service.dart';

class ProductController extends GetxController {
  // var advice = {}.obs;
  var productlist = StitchProductModel(data: []).obs;
  var products = ProductModel(data: []).obs;
  // var productlist = <Product>[].obs;

  var isLoading = true.obs;

  Future fetchData() async {
    try {
      isLoading(true);

      var response = await RemoteService().fetchProduct();
      if (response != null) {
        productlist.value = response;
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

      var response = await RemoteService().fetchProductDetails(id);
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
