import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/controller/invoice_controller.dart';
import 'package:newtailor/pages/bottomnavigation/cart/checkout.dart';
import 'package:newtailor/services/service.dart';
import 'package:newtailor/utility/auth.dart';
import 'package:newtailor/view/login.dart';

import 'package:newtailor/view/purchase_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/bottomnavigation/dashboard.dart';
import '../pages/drawer/privacy.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
}

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var token, name, email;
  checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    name = preferences.getString("name");
    email = preferences.getString("email");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  var cartcountroller = Get.find<CartController>();
  var purchasecontroller = Get.find<InvoiceController>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.blue,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            setState(() {});
            index = value;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Profile"),
          ]),
      body: index == 0
          ? const DashboradScreen()
          : index == 1
              ? token == null
                  ? const SignIn()
                  : const CheckoutScreen()
              : SafeArea(
                  child: token == null
                      ? Card(
                          child: SizedBox(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Would you like to login?"),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => const SignIn());
                                      },
                                      child: const Text("Ok",
                                          style: TextStyle(
                                            fontSize: 25,
                                          )))
                                ],
                              ),
                            ),
                          ),
                        )
                      : Drawer(
                          child: ListView(
                            children: [
                              UserAccountsDrawerHeader(
                                accountName: Text(name ?? "Guest"),
                                accountEmail:
                                    Text(email ?? "guest@tailorjoin.com"),
                                currentAccountPicture: CircleAvatar(
                                  child: Text(Authentication.name == null
                                      ? "G"
                                      : Authentication.name
                                          .toString()
                                          .substring(0, 1)
                                          .toUpperCase()),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(() => const PurchaseHistoryScreen());
                                  purchasecontroller.getPurchaseHistory();
                                },
                                title: const Text("Purchase History"),
                              ),
                              ListTile(
                                title:
                                    const Text('Privacy & Terms Of Conditions'),
                                onTap: () {
                                  Get.to(() => const PrivacyScreen());
                                },
                              ),
                              token == null
                                  ? ListTile(
                                      title: const Text('Sign In'),
                                      onTap: () {
                                        Get.to(() => const SignIn());
                                      },
                                    )
                                  : ListTile(
                                      title: const Text('LogOut'),
                                      onTap: () {
                                        RemoteService.logout();
                                      },
                                    ),
                            ],
                          ),
                        ),
                ),
    );
  }
}
