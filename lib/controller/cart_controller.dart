import 'package:get/get.dart';
import 'package:newtailor/model/cart_model.dart';
import 'package:newtailor/services/service.dart';

class CartController extends GetxController {
  // var advice = {}.obs;
  var cartItems = CartModel(data: []).obs;
  // var productlist = <Product>[].obs;

  var isLoading = true.obs;

  Future getCartData() async {
    try {
      isLoading(true);

      var response = await RemoteService().fetchCartDetails();
      if (response != null) {
        cartItems.value = response;
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
