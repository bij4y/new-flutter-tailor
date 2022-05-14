import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/controller/tailorcontroller.dart';
import 'package:get/get.dart';
import 'package:newtailor/services/service.dart';
import 'package:newtailor/view/rating_dialog.dart';
import '../../utility/chip.dart';

class TailorDetails extends StatefulWidget {
  const TailorDetails({Key? key}) : super(key: key);

  @override
  State<TailorDetails> createState() => _TailorDetailsState();
}

class _TailorDetailsState extends State<TailorDetails> {
  var total = 1;
  @override
  Widget build(BuildContext context) {
    var tailorController = Get.find<TailorController>();
    var cartcontroller = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(body: Obx(() {
        if (tailorController.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  //--------------------------------------------image--------------------------------------//
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.network(
                      tailorController.products.value.data[0].logo,
                      fit: BoxFit.fill,
                    ),
                  ),
                  //--------------------------------------------image end--------------------------------------//

                  //--------------------------------------------name to --------------------------------------//

                  Padding(
                    padding: const EdgeInsets.only(top: 230),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //------------------------profile pic----------------------------//
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    tailorController
                                        .products.value.data[0].category,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 28),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      tailorController
                                          .products.value.data[0].address,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  color: Colors.white,
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.favorite_border_outlined))
                            ],
                          ),
                        ),
                        //------------------------ Rating  and reviews----------------------------//
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        RatingStars(
                                          value: double.parse(tailorController
                                              .products
                                              .value
                                              .data[0]
                                              .rating
                                              .rating),
                                          onValueChanged: (v) {
                                            //
                                          },
                                          starBuilder: (index, color) => Icon(
                                            Icons.star_outline,
                                            color: color,
                                          ),
                                          starCount: 5,
                                          starSize: 20,
                                          valueLabelColor:
                                              const Color(0xff9b9b9b),
                                          valueLabelTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.0),
                                          valueLabelRadius: 10,
                                          maxValue: 5,
                                          starSpacing: 2,
                                          maxValueVisibility: true,
                                          valueLabelVisibility: true,
                                          animationDuration: const Duration(
                                              milliseconds: 1000),
                                          valueLabelPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1, horizontal: 8),
                                          valueLabelMargin:
                                              const EdgeInsets.only(right: 8),
                                          starOffColor: const Color(0xffe7e8ea),
                                          starColor: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.ac_unit,
                                          color: Colors.black87,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Get.to(
                                                  () => const RatingDialog());
                                            },
                                            child: const Text(
                                              "Rate This Tailor",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //------------------------ elevated botton  and description----------------------------//
                        Column(
                          children: [
                            ListTile(
                              title: const Text(
                                "Description",
                              ),
                              subtitle: Text(tailorController
                                  .products.value.data[0].address),
                            ),
                          ],
                        ),
                        //------------------------ elevated botton  and description ends---------------------------//

                        //------------------------ Chip---------------------------//
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            CustomChip(
                              title: "Free Delivery",
                              icon: Icons.directions_bike,
                            ),
                            CustomChip(
                              title: "Emergency Stitch",
                              icon: Icons.fast_forward,
                            ),
                          ],
                        ),
                        //------------------------ Chip---------------------------//

                        const Divider(),
                        const ListTile(
                          trailing: Text(
                            "Services",
                            style: TextStyle(color: Colors.green),
                          ),
                          title: Text(
                            "Stitch Rates",
                            // textScaleFactor: 1.3,
                          ),
                          subtitle: Text("Find suitable cost for stitch"),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: tailorController
                                      .products.value.data.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var mydata = tailorController
                                        .products.value.data[index];
                                    return Column(
                                      children: [
                                        Card(
                                          child: ListTile(
                                            trailing: Image.network(
                                              mydata.image,
                                            ),
                                            // leading: Icon(Icons.ac_unit_rounded),
                                            title: Text(
                                              mydata.name,
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    "Special services in stay home"),
                                                Text(
                                                  "Rs. ${mydata.sp}",
                                                  textScaleFactor: 1.4,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // OutlinedButton(
                                                    //   onPressed: () {},
                                                    //   style: ButtonStyle(
                                                    //     shape: MaterialStateProperty
                                                    //         .all<
                                                    //             RoundedRectangleBorder>(
                                                    //       RoundedRectangleBorder(
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(100),
                                                    //         side: const BorderSide(
                                                    //             color:
                                                    //                 Colors.green),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       IconButton(
                                                    //         icon: const Icon(Icons
                                                    //             .remove_circle),
                                                    //         onPressed: () {
                                                    //           mydata.qty--;
                                                    //           if (mydata.qty < 1) {
                                                    //             mydata.qty = 1;
                                                    //           }
                                                    //           setState(() {});
                                                    //         },
                                                    //       ),
                                                    //       Text(
                                                    //         mydata.qty.toString(),
                                                    //         style: const TextStyle(
                                                    //             fontSize: 20,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .w600),
                                                    //       ),
                                                    //       IconButton(
                                                    //         icon: const Icon(
                                                    //             Icons.add_circle),
                                                    //         onPressed: () {
                                                    //           mydata.qty++;
                                                    //           setState(() {});
                                                    //         },
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    MaterialButton(
                                                      textColor: Colors.green,
                                                      onPressed: () {
                                                        Map data = {
                                                          'product_id':
                                                              mydata.id,
                                                          'qty': 1,
                                                          'amount': mydata.qty *
                                                              mydata.sp,
                                                        };

                                                        RemoteService.addToCart(
                                                                data)
                                                            .whenComplete(() {
                                                          cartcontroller
                                                              .getCartData();
                                                        });
                                                      },
                                                      child: const Text(
                                                          "Stitch Now"),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
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
                  ),
                ],
              ),
            ),
          );
        }
      })),
    );
  }
}
