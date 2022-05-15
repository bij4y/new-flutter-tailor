import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/carousel_controller.dart';
import 'package:newtailor/controller/cart_controller.dart';
import 'package:newtailor/controller/product_controller.dart';
import 'package:newtailor/controller/tailorcontroller.dart';
import 'package:newtailor/pages/bottomnavigation/cart/checkout.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:newtailor/pages/dashboarddetails/productdetails.dart';
import 'package:newtailor/pages/dashboarddetails/tailordetails.dart';
import 'package:newtailor/utility/auth.dart';
import 'package:newtailor/view/login.dart';
import 'package:newtailor/view/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboradScreen extends StatefulWidget {
  const DashboradScreen({Key? key}) : super(key: key);

  @override
  State<DashboradScreen> createState() => _DashboradScreenState();
}

class _DashboradScreenState extends State<DashboradScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var token;
  checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
    Authentication.checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    var cartcountroller = Get.find<CartController>();
    var productcontroller = Get.find<ProductController>();
    var tailorcontroller = Get.find<TailorController>();
    var carouselcontroller = Get.find<CarouselController>();
    cartcountroller.getCartData();
    return SafeArea(
        child: Scaffold(
            // bottomNavigationBar: const BottomNavigatorScreen(),
            appBar: AppBar(
              actions: [
                Row(
                  children: [
                    const SizedBox(width: 10),

                    //  IconButton(
                    //           onPressed: () => Navigator.of(context)
                    //               .push(MaterialPageRoute(builder: (_) => SearchPage())),
                    //           icon: Icon(Icons.search)),

                    IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        Get.to(const SearchPage());
                      },
                    ),
                    const SizedBox(width: 10),
                    Badge(
                      badgeColor: Colors.red,
                      badgeContent: token == null
                          ? const Text(
                              "0",
                              style: const TextStyle(color: Colors.white),
                            )
                          : Obx(
                              () => Text(
                                "${cartcountroller.cartItems.value.data.length}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          token == null
                              ? Get.to(() => const SignIn())
                              : Get.to(() => const CheckoutScreen());
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ],
              title: const Text(
                "Idris",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.blue),
              ),
            ),

            //--------------------appbar Ends---------------------//

            //--------------------body starts---------------------//
            body: Obx(() {
              if (tailorcontroller.isLoading.value == true) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //----------------------------Location-----------------------------------//

                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 169, 191, 1),
                              Colors.greenAccent,
                            ],
                          ),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              child: ListTile(
                                horizontalTitleGap: -8,
                                leading: Icon(
                                  Icons.place_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Deliver to ithari ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text("Nepal",
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //----------------------------Location Ends-----------------------------------//

                      const SizedBox(
                        height: 2,
                      ),

                      //----------------------------Image-----------------------------------//
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            height: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                carouselcontroller
                                    .carousel.value.data[0].feature,
                                fit: BoxFit.cover,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xff30404f),
                            ),
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),

                      //----------------------------Image ends-----------------------------------//

                      //----------------------------Tailors Near you Text-----------------------------------//
                      const ListTile(
                        trailing: Text(
                          "View All",
                          style: TextStyle(color: Colors.green),
                        ),
                        title: Text(
                          "Tailors Near You",
                          textScaleFactor: 1.1,
                        ),
                      ),

                      //----------------------------Tailors Near you Text Ends-----------------------------------//

                      //----------------------------Tailors Near gridview-----------------------------------//
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount:
                              tailorcontroller.tailorlist.value.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            // crossAxisCount: 2,

                            return InkWell(
                              onTap: () {
                                tailorcontroller.fetchProduct(tailorcontroller
                                    .tailorlist.value.data[index].id);
                                Get.to(() => const TailorDetails());
                              },
                              child: Card(
                                color: const Color(0xffF8F8F8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        tailorcontroller.tailorlist.value
                                            .data[index].feature,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(tailorcontroller
                                        .tailorlist.value.data[index].name),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        RatingStars(
                                          value: double.parse(tailorcontroller
                                              .tailorlist
                                              .value
                                              .data[index]
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
                                  ],
                                ),
                              ),
                            );
                          }),
                      //----------------------------Tailors Near gridview-----------------------------------//

                      //----------------------------Shop Materials-----------------------------------//
                      Card(
                        child: ListTile(
                          trailing: TextButton(
                              onPressed: () {
                                // Get.to(() => const productlistView());
                              },
                              child: const Text("View All")),
                          title: const Text(
                            "Shop Your Materials",
                            textScaleFactor: 1.1,
                          ),
                        ),
                      ),

                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              productcontroller.productlist.value.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var mydata =
                                productcontroller.productlist.value.data[index];
                            return InkWell(
                              onTap: () {
                                productcontroller.fetchProduct(productcontroller
                                    .productlist.value.data[index].id);

                                Get.to(() => const ProductDetailsPage());
                              },
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        mydata.feature,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        mydata.name,
                                        textScaleFactor: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      //----------------------------Shop Materials Ends-----------------------------------//

                      //----------------------------Shop Listview-----------------------------------//
                    ],
                  ),
                );
              }
            })
            //--------------------body Ends---------------------//
            ));
  }
}
//