import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/controller/product_controller.dart';
import 'package:newtailor/services/service.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    var productcontroller = Get.find<ProductController>();
    var cartcontroller = Get.find<CartController>();

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffF8F8F8),
          body: Obx(() {
            if (productcontroller.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 500,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount:
                                  productcontroller.products.value.data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var mydata = productcontroller
                                    .products.value.data[index];
                                return Column(
                                  children: [
                                    Container(
                                      child: Image.network(
                                        mydata.image,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        mydata.name,
                                        textScaleFactor: 1.8,
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Icon(
                                            Icons.ac_unit,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          const Text(" Rate this Product"),
                                        ],
                                      ),
                                      trailing: Text(
                                        "Rs. ${mydata.sp}",
                                        style:
                                            TextStyle(color: Colors.red[800]),
                                        textScaleFactor: 1.7,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text("Short Description"),
                                      subtitle: Text(
                                          "Special services in stay home Special services in stay homeSpecial services in stay home Special services in stay homeSpecial services in stay homeSpecial services in stay homeSpecial services in stay homeSpecial services in stay homeSpecial services in stay home"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: Get.size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.remove_circle,
                                                          size: 30,
                                                        ),
                                                        onPressed: () {
                                                          mydata.qty--;
                                                          if (mydata.qty < 1) {
                                                            mydata.qty = 1;
                                                          }
                                                          setState(() {});
                                                        },
                                                      ),
                                                      Text(
                                                        mydata.qty.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.add_circle,
                                                            size: 30),
                                                        onPressed: () {
                                                          mydata.qty++;
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Map data = {
                                                    'product_id': mydata.id,
                                                    'qty': mydata.qty,
                                                    'amount':
                                                        mydata.qty * mydata.sp,
                                                  };

                                                  RemoteService.addToCart(data)
                                                      .whenComplete(() {
                                                    cartcontroller
                                                        .getCartData();
                                                  });
                                                },
                                                child:
                                                    const Text("Add To Cart"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          })),
    );
  }
}
