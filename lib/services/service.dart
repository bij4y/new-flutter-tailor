import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:newtailor/model/carousel_model.dart';
import 'package:newtailor/model/cart_model.dart';
import 'package:newtailor/model/invoicedetails_model.dart';
import 'package:newtailor/model/invoicemodel.dart';
import 'package:newtailor/model/product_model.dart';
import 'package:newtailor/model/search_model.dart';
import 'package:newtailor/model/stitch_productmodel.dart';
import 'package:newtailor/model/tailormodel.dart';
import 'package:newtailor/view/bottomnavigation.dart';
import 'package:newtailor/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteService {
  static String baseUrl = "http://tailorjoin.com/api";
  static var client = http.Client();
  Future<TailorModel?> fetchTailorData() async {
    try {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // String? token = preferences.getString('token');

      var response =
          await client.get(Uri.parse("$baseUrl/categorywith"), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return tailorModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //Products
  Future<StitchProductModel?> fetchProduct() async {
    try {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // String? token = preferences.getString('token');

      var response =
          await client.get(Uri.parse("$baseUrl/stitchproduct"), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return stitchProductModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //ProductDetails
  Future<ProductModel?> fetchProductDetails(int id) async {
    try {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // String? token = preferences.getString('token');

      var response =
          await client.get(Uri.parse("$baseUrl/stitchproduct/$id"), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return productModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<InvoiceModel?> fetchPurchase() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.get(Uri.parse("$baseUrl/invoice"), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return invoiceModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<InvoiceDetaiModel?> fetchPurchaseHistory(int id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.get(Uri.parse("$baseUrl/invoice/$id"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return invoiceDetaiModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<ProductModel?> fetchTailorDetail(int id) async {
    try {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // String? token = preferences.getString('token');

      var response =
          await client.get(Uri.parse("$baseUrl/categorywith/$id"), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return productModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future loginRegister() async {
    try {
      var response = await http.post(Uri.parse("$baseUrl/login"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return jsonEncode(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future addToCart(Map data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.post(Uri.parse("$baseUrl/cart"),
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(data));

      if (response.statusCode == 401) {
        Get.offAll(const SignIn());
      } else if (response.statusCode == 200) {}
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future postData(Map data, String endPoint) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.post(Uri.parse("$baseUrl/$endPoint"),
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Get.snackbar("Message", result['message']);
        Get.offAll(() => const BottomNavigatorScreen());
      } else {
        var result = jsonDecode(response.body);
        Get.snackbar("Message", result['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future<SearchModel?> search(String query) async {
    try {
      var response =
          await client.get(Uri.parse("$baseUrl/products/search/$query"));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return searchModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future<CartModel?> editCartItem(Map data, int id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.put(Uri.parse("$baseUrl/cart/$id"),
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // ignore: avoid_print
        print(jsonData);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future deleteCatItem(int id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.delete(
        Uri.parse("$baseUrl/cart/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //Fetch Cart Items
  Future<CartModel?> fetchCartDetails() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      var response = await client.get(Uri.parse("$baseUrl/cart"), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return cartModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<CarouselModel?> carousel() async {
    try {
      var response =
          await client.get(Uri.parse("$baseUrl/carousels"), headers: {
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        var jsonData = response.body;
        return carouselModelFromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  //logout
  static Future logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      var response = await client.post(
        Uri.parse("$baseUrl/logout"),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        preferences.remove("token");
        preferences.remove("name");
        preferences.remove("email");
        preferences.remove("id");
        Get.off(() => const SignIn());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
