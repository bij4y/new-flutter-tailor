import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/invoice_controller.dart';
import 'package:newtailor/view/purchased_detail.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var purchasecontroller = Get.find<InvoiceController>();

    return Obx(
      () => Scaffold(
        bottomNavigationBar: purchasecontroller.purchaseItem.value.data.isEmpty
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
                                  purchasecontroller
                                          .purchaseItem.value.data.isEmpty
                                      ? const Text("Selected Items(0)")
                                      : Text(
                                          "Purchased Items(${purchasecontroller.purchaseItem.value.data.length})"),
                                  purchasecontroller
                                          .purchaseItem.value.data.isEmpty
                                      ? const Text("Total : 0.0")
                                      : Text(
                                          "Total : ${purchasecontroller.purchaseItem.value.data[0].finalamount}"),

                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
        appBar: AppBar(
          title: const Text(
            "Purchase History",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                purchasecontroller.purchaseItem.value.data.isEmpty
                    ? const Center(
                        child: Text("Not purchased yet"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            purchasecontroller.purchaseItem.value.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                      "Rs. ${purchasecontroller.purchaseItem.value.data[index].total}"),
                                ],
                              ),
                              trailing: TextButton(
                                  onPressed: () {
                                    purchasecontroller.fetchInvoiceDetail(
                                        purchasecontroller
                                            .purchaseItem.value.data[index].id);
                                    Get.to(() => const PurchaseDetails());
                                  },
                                  child: const Text("View Details")),
                            ),
                          );
                        })
              ],
            ),
          );
        }),
      ),
    );
  }
}
