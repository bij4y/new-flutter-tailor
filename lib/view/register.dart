import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/api.dart';
import 'package:newtailor/utility/form.dart';
import 'package:newtailor/view/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _value = 1;
  bool donkey = true;
  bool npl = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  void _showialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Register "),
          content: const Text(
            "Registration Successful",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Get.off(const SignIn());
              },
            ),
          ],
        );
      },
    );
  }

  void _showdialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Registration Failed",
          ),
          content: const Text(
            "Please Enter Valid data",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Get.off(const SignIn());
              },
            ),
          ],
        );
      },
    );
  }

  void _showpialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Registration Failed",
          ),
          content: const Text(
            "Email already Exists",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Get.off(const SignIn());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1,
                  fontSize: 23,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/dashboard");
                          },
                          child: Radio(
                              value: 1,
                              groupValue: _value,
                              onChanged: (val) {
                                setState(() {
                                  _value = _value;
                                });
                              }),
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Create an account  ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: 'Are you new?',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(const SignIn());
                      },
                      child: Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: _value,
                              onChanged: (val) {
                                setState(() {
                                  _value = _value;
                                });
                              }),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Already. sign-In?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: TextForm.horizontalScreenPadding,
                                vertical: TextForm.verticalscreenPadding),
                            child: TextFormField(
                              controller: name,
                              validator: (value) =>
                                  value!.isEmpty ? "Required" : null,
                              decoration: const InputDecoration(
                                hintText: "Name",
                                prefixIcon: Icon(
                                  Icons.person_add,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: TextForm.horizontalScreenPadding,
                                vertical: TextForm.verticalscreenPadding),
                            child: TextFormField(
                              controller: mobile,
                              validator: (value) =>
                                  value!.isEmpty ? "Required" : null,
                              decoration: const InputDecoration(
                                hintText: "Contact",
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: TextForm.horizontalScreenPadding,
                                vertical: TextForm.verticalscreenPadding),
                            child: TextFormField(
                              controller: email,
                              validator: (value) =>
                                  value!.isEmpty ? "Required" : null,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: TextForm.horizontalScreenPadding,
                                vertical: TextForm.verticalscreenPadding),
                            child: TextFormField(
                              controller: password,
                              obscureText: donkey,
                              validator: (value) =>
                                  value!.isEmpty ? "Required" : null,
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
                                hintText: "Password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: TextForm.horizontalScreenPadding,
                                vertical: TextForm.verticalscreenPadding),
                            child: TextFormField(
                              controller: cpassword,
                              obscureText: npl,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      npl = !npl;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      npl == false
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    )),
                                hintText: "Confirm Password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                              ),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return "required";
                                }
                                if (password.text != password.text) {
                                  return "password don't match";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  Map data = {
                                    'name': name.text,
                                    'email': email.text,
                                    'mobile': mobile.text,
                                    'password': password.text,
                                  };

                                  var response = await Api()
                                      .loginRegister(data, 'register');
                                  var result = json.decode(response.body);
                                  if (result['code'] == 401) {
                                    _showdialog(context);
                                  }
                                  if (result['code'] == 200) {
                                    _showialog(context);
                                  }
                                  if (result['code'] == 500) {
                                    _showpialog(context);
                                  }
                                }
                              },
                              child: const Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "By continuing,you agree to Tailor Conditions of Use and Privacy Notice.",
                        textScaleFactor: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
