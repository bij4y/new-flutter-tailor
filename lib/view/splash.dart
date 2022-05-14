import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/utility/auth.dart';
import 'package:newtailor/view/bottomnavigation.dart';

import 'onboarding.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Authentication.checkAuth();
    _navigatetohome();
  }

  void _navigatetohome() async {
    // ignore: prefer_const_constructors
    await Future.delayed(Duration(milliseconds: 3000), () {
      Authentication.token == null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OnboardingPage()))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigatorScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: Get.size.height,
                width: Get.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/splash.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                child: Column(
                  children: [
                    SizedBox(
                        width: Get.size.width,
                        height: 50,
                        child: const CupertinoActivityIndicator()),
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Powered by Unicorn softtech.",
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
