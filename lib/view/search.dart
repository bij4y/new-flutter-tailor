import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtailor/controller/product_controller.dart';
import 'package:newtailor/controller/search_controller.dart';
import 'package:newtailor/controller/tailorcontroller.dart';
import 'package:newtailor/pages/dashboarddetails/productdetails.dart';
import 'package:newtailor/pages/dashboarddetails/tailordetails.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    var searchController = Get.find<SearchController>();
    var tailorcontroller = Get.find<TailorController>();
    var productcontroller = Get.find<ProductController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Search Location',
                suffixIcon: IconButton(
                    onPressed: () {
                      searchController.searchData(name.text);
                    },
                    icon: const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              if (searchController.isLoading.value == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchController.tailorlist.value.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var mydata = searchController.tailorlist.value.data[index];
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            tailorcontroller.fetchProduct(tailorcontroller
                                .tailorlist.value.data[index].id);
                            Get.to(() => const TailorDetails());
                          },
                          leading: Image.network(
                            mydata.feature,
                            fit: BoxFit.cover,
                          ),
                          title: Text(mydata.name),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.place),
                              Text(mydata.address)
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
