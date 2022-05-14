import 'package:get/get.dart';
import 'package:newtailor/model/invoicedetails_model.dart';
import 'package:newtailor/model/invoicemodel.dart';
import 'package:newtailor/services/service.dart';

class InvoiceController extends GetxController {
  var purchaseItem = InvoiceModel(data: []).obs;
  var purchaseItemDetail = InvoiceDetaiModel(data: []).obs;
  var isLoading = true.obs;
  Future getPurchaseHistory() async {
    try {
      isLoading(true);

      var response = await RemoteService().fetchPurchase();
      if (response != null) {
        purchaseItem.value = response;
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future fetchInvoiceDetail(int id) async {
    try {
      isLoading(true);

      var response = await RemoteService().fetchPurchaseHistory(id);
      if (response != null) {
        purchaseItemDetail.value = response;
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
