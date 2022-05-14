// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserController extends GetxController {
//   var isLoading = true.obs;
//   var email=''.obs, id=0.obs, name=''.obs;

//   Future getPurchaseHistory() async {
//     try {
//       isLoading(true);

//       SharedPreferences preference = await SharedPreferences.getInstance();
//       email = preference.get('email');
//       id = preference.get('id');
//       name = preference.get('name');
//     } catch (e) {
//       Get.snackbar("Message", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
