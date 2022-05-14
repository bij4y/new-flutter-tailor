import 'package:get/get.dart';
import 'package:newtailor/model/search_model.dart';
import 'package:newtailor/services/service.dart';

class SearchController extends GetxController {
  // var advice = {}.obs;
  var tailorlist = SearchModel(data: []).obs;

  var isLoading = true.obs;

  Future searchData(String query) async {
    try {
      isLoading(true);

      var response = await RemoteService.search(query);
      if (response != null) {
        tailorlist.value = response;
      }
    } catch (e) {
      Get.snackbar("Message", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
