import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/tailorcontroller.dart';
import 'package:newtailor/services/service.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  @override
  Widget build(BuildContext context) {
    var categorycontroller = Get.find<TailorController>();

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            Map data = {
              "rating": rating,
              "category_id": categorycontroller.products.value.data[0].id
            };
            RemoteService.postData(data, 'rating');
          },
        )),
        // TextButton(
        //     onPressed: () {
        //       Map data = {
        //         "rating": rating,
        //         "total": cartController.cartItems.value.data[0].total,
        //         "products": cartController.cartItems.value.data.map((e) {
        //           return {
        //             "product_id": e.productId,
        //             "qty": e.qty,
        //             "amount": e.amount
        //           };
        //         }).toList()
        //       };
        //     },
        //     child: Text("Submit"))
      ],
    ));
  }
}
