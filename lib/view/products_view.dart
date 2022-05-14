// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:newtailor/controller/cart_controller.dart';
// import 'package:newtailor/controller/product_controller.dart';
// import 'package:newtailor/pages/dashboarddetails/productdetails.dart';

// class ProductsView extends StatefulWidget {
//   const ProductsView({Key? key}) : super(key: key);

//   @override
//   State<ProductsView> createState() => _ProductsViewState();
// }

// class _ProductsViewState extends State<ProductsView> {
//   var productcontroller = Get.find<ProductController>();
//   var cartcontroller = Get.find<CartController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Products",
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//            Row(
//                   children: [
//                     const SizedBox(width: 10),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.search,
//                       ),
//                       onPressed: () {
//                         Get.to(const SearchPage());
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     Badge(
//                       badgeColor: const Color(0xffc19a67),
//                       badgeContent: token == null
//                           ? const Text("0")
//                           : Obx(
//                               () => Text(
//                                 "${cartcountroller.cartItems.value.data.length}",
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                       child: IconButton(
//                         icon: const Icon(Icons.shopping_cart_outlined),
//                         onPressed: () {
//                           token == null
//                               ? Get.to(() => const SignIn())
//                               : Get.to(() => const CheckoutScreen());
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                   ],
//                 ),
//               ],
//         ],
//               ),
//       body: Obx(
//         () => SingleChildScrollView(
//           child: Column(
//             children: [
//               GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                   ),
//                   itemCount: productcontroller.productlist.value.data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     // crossAxisCount: 2,
//                     var mydata =
//                         productcontroller.productlist.value.data[index];
//                     return InkWell(
//                       onTap: () {
//                         productcontroller.fetchProduct(
//                             productcontroller.productlist.value.data[index].id);
//                         Get.to(() => const ProductDetailsPage());
//                       },
//                       child: Card(
//                         color: const Color(0xffF8F8F8),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Image.network(
//                                 mydata.image,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 7,
//                             ),
//                             ListTile(
//                                 title: Text(
//                                   mydata.name,
//                                   textScaleFactor: 1.3,
//                                 ),
//                                 subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Rs. ${mydata.sp}",
//                                         textScaleFactor: 1.5,
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                       )
//                                     ]))
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
