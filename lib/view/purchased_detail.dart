import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/invoice_controller.dart';

class PurchaseDetails extends StatelessWidget {
  const PurchaseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var purchasedcontroller = Get.find<InvoiceController>();

    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (purchasedcontroller.isLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: purchasedcontroller
                          .purchaseItemDetail.value.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(purchasedcontroller
                                .purchaseItemDetail.value.data[index].image),
                            title: Text(purchasedcontroller
                                .purchaseItemDetail.value.data[index].name),
                            subtitle: Text(
                                "Rs. ${purchasedcontroller.purchaseItemDetail.value.data[index].sp}"),
                            trailing: Text(
                                "Qty ${purchasedcontroller.purchaseItemDetail.value.data[index].qty}"),
                          ),
                        );
                      })
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
