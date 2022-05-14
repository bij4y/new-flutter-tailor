import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/view/bottomnavigation.dart';
import 'package:newtailor/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  bool donkey = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var cartcountroller = Get.find<CartController>();

  late ScaffoldMessengerState scaffoldMessenger;
  void _showialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Oops!",
          ),
          content: const Text(
            "Please login with valid number and password",
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Image.asset(
                    "images/splash.jpg",
                    height: 240,
                    width: 240,
                    alignment: Alignment.center,
                  )),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _key,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 45),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: email,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.phone_android),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: "Mobile",
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: password,
                            obscureText: donkey,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    donkey = !donkey;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    donkey == false
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  )),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              prefixIcon: const Icon(Icons.lock),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (_key.currentState!.validate()) {
                                    Map data = {
                                      'mobile': email.text,
                                      'password': password.text
                                    };
                                    var response = await Api()
                                        .loginRegister(data, 'login');
                                    var result = json.decode(response.body);
                                    if (result['code'] == 500) {
                                      _showialog(context);
                                    }
                                    if (result['code'] == 200) {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      preferences.setString(
                                          'token', result['token']);
                                      preferences.setString(
                                          'email', result['email']);
                                      preferences.setString(
                                          'name', result['name']);
                                      preferences.setString(
                                          'mobile', result['mobile']);
                                      cartcountroller.getCartData();
                                      Get.offAll(
                                          () => const BottomNavigatorScreen());
                                    }
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: (isLoading)
                                    ? const Center(
                                        child: SizedBox(
                                            height: 26,
                                            width: 26,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.green,
                                            )))
                                    : Container(),
                                right: 30,
                                bottom: 0,
                                top: 0,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              cartcountroller.getCartData().whenComplete(() {
                                Get.offAll(() => const BottomNavigatorScreen());
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                "Skip For Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const RegisterScreen());
                    },
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          letterSpacing: 0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Positioned(
                bottom: 20,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "By continuing,you agree to Tailor Conditions of Use and \nPrivacy Notice.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
