import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/bindings/controller_bindings.dart';
import 'package:newtailor/pages/bottomnavigation/cart/shipping.dart';
import 'package:newtailor/view/register.dart';
import 'package:newtailor/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme.of(context).copyWith(
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconTheme.of(context).copyWith(color: Colors.black)),
      ),
      initialBinding: ControllerBinding(),
      home: const SpalshScreen(),
      routes: {
        "/shippingaddress": (context) => ShippingScreen(),
        "signup": (context) => const RegisterScreen(),
      },
    );
  }
}
