import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/carousel_controller.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/services/service.dart';
import 'package:newtailor/utility/auth.dart';

// ignore: must_be_immutable
class ShippingScreen extends StatelessWidget {
  ShippingScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    var carouselcontroller = Get.find<CarouselController>();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 5),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cartController.cartItems.value.data.isEmpty
                              ? const Text("Selected Items(0)")
                              : Text(
                                  "Selected Items(${cartController.cartItems.value.data.length})"),
                          cartController.cartItems.value.data.isEmpty
                              ? const Text("Total : 0.0")
                              : Text(
                                  "Total : ${cartController.cartItems.value.data[0].total}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffffbf00)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Order',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                Map data = {
                                  "address": address.text,
                                  "total": cartController
                                      .cartItems.value.data[0].total,
                                  "products": cartController
                                      .cartItems.value.data
                                      .map((e) {
                                    return {
                                      "product_id": e.productId,
                                      "qty": e.qty,
                                      "amount": e.amount
                                    };
                                  }).toList()
                                };
                                RemoteService.postData(data, 'invoice');
                                cartController.getCartData();
                              }
                            },
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: const Text(
          "Select your shipping address",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Obx(
              () => Image.network(
                  carouselcontroller.carousel.value.data[1].feature),
            ),
            Form(
              key: _key,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Authentication.name,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Edit",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Authentication.email,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Authentication.mobile,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                        controller: address,
                        decoration:
                            const InputDecoration(hintText: "shipping address"),
                      ),
                      const SizedBox(
                        child: Divider(),
                      ),
                      const ListTile(
                        title: Text("Payment System"),
                        subtitle: Text("Your payment will be on deliver"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
