import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
            size: 22,
            // color: Color(0xff30404f),
            color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
                // topLeft: Radius.circular(200)
              ),
              color: Color(0xffEAEAEA),
              shape: BoxShape.rectangle,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "This privacy policy is effective as of April,2021.Tailor.com is commited to protecting your privacy providing you the most powerful and safe online experience.This policy document intends to help you understand how personal information you provide to tailor.com(Tailor App).is collected and used,so you can make informed decision when using the website located at http.tailor.com . By using Taiorapp,you consent to the data practicles described in this statement.If you continue to use TailorApp and services after this notices of changes have been posted to the site,you hereby provide your consent to the changed particles.if you have any questions regarding this Privacy Policy,please contact; tailorapp@gmail.com.",
                  style:
                      TextStyle(fontSize: 17, color: Colors.black, height: 1.6),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
