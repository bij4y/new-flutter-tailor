import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  // ignore: prefer_typing_uninitialized_variables
  static var token;
  // ignore: prefer_typing_uninitialized_variables
  static var id;
  // ignore: prefer_typing_uninitialized_variables
  static var name;
  // ignore: prefer_typing_uninitialized_variables
  static var email;
  // ignore: prefer_typing_uninitialized_variables
  static var mobile;
  static void checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');
    id = preferences.getString('id');
    name = preferences.getString('name');
    email = preferences.getString('email');
    mobile = preferences.getString('mobile');
  }
}
