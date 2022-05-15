import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/pages/bottomnavigation/cart/shipping.dart';
import 'package:newtailor/services/service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();

    return SafeArea(
      child: Obx(
        () => Scaffold(
          bottomNavigationBar: cartController.cartItems.value.data.isEmpty
              ? const SizedBox()
              : BottomAppBar(
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
                                color: Colors.black38,
                                spreadRadius: 0,
                                blurRadius: 5),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xffffbf00)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          'Proceed to checkout',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.to(() => ShippingScreen());
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
            title: const Text(
              "cart",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(size: 22, color: Colors.black),
            elevation: 0.5,
          ),
          body: Obx(
            () => Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    cartController.cartItems.value.data.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.shopping_basket,
                                size: 100,
                                color: Colors.grey,
                              ),
                              Text(
                                "No Items In Basket\n Please buy Something!!!",
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                cartController.cartItems.value.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var mydata =
                                  cartController.cartItems.value.data[index];
                              return Column(
                                children: [
                                  Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Image.network(
                                              mydata.productFeature),
                                          title: Text(
                                            mydata.productName,
                                            style:
                                                const TextStyle(fontSize: 25),
                                          ),
                                        ),
                                        ListTile(
                                          subtitle: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    mydata.qty--;
                                                    if (mydata.qty < 1) {
                                                      mydata.qty = 1;
                                                    }
                                                    Map data = {
                                                      'qty': mydata.qty,
                                                      'amount': mydata.qty *
                                                          mydata.rate,
                                                    };

                                                    RemoteService.editCartItem(
                                                            data, mydata.id)
                                                        .whenComplete(() =>
                                                            cartController
                                                                .getCartData());
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_circle,
                                                    size: 28,
                                                    color: Colors.grey,
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  "${mydata.qty}",
                                                  style: const TextStyle(
                                                      fontSize: 28),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    mydata.qty++;
                                                    Map data = {
                                                      'qty': mydata.qty,
                                                      'amount': mydata.qty *
                                                          mydata.rate,
                                                    };

                                                    RemoteService.editCartItem(
                                                            data, mydata.id)
                                                        .whenComplete(() =>
                                                            cartController
                                                                .getCartData());
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                    Icons.add_circle,
                                                    size: 28,
                                                    color: Colors.grey,
                                                  )),
                                            ],
                                          ),
                                          trailing: TextButton(
                                            onPressed: () {
                                              RemoteService.deleteCatItem(
                                                      mydata.id)
                                                  .whenComplete(() {
                                                cartController.getCartData();
                                              });
                                            },
                                            child: const Text(
                                              "delete",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
