import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/search/searchcontroller.dart';
import 'package:sire/core/class/handlingdataview.dart';
import 'package:sire/core/constant/color.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    SearchControllerImp searchControllerImp = Get.put(SearchControllerImp());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: TypeAheadField<String>(
              decorationBuilder: (context, child) {
                return Container(
                  height: 200,
                  padding: EdgeInsets.only(bottom: 8, top: 4),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 241, 245),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      )),
                  child: child,
                );
              },
              builder: (context, controller, focusNode) {
                searchControllerImp.textEditingController = controller;
                searchControllerImp.textEditingController!.text =
                    searchControllerImp.input;
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
                    searchControllerImp.search(value);
                  },
                );
              },
              itemBuilder: (context, String value) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(Icons.search,
                                  color: Colors.blueAccent, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              onSelected: (value) {
                searchControllerImp.textEditingController!.text = value;
                searchControllerImp.search(value);
              },
              suggestionsCallback: (search) {
                return SearchControllerImp.getSuggestions(
                    search, searchControllerImp.suggestions);
              },
            )),
        body: GetBuilder<SearchControllerImp>(
          builder: (controller) => HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${controller.results.length} items found',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.results.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(endIndent: 20, indent: 20),
                          SizedBox(height: 10),
                          Material(
                            color: Appcolor
                                .white, 
                            child: InkWell(
                              onTap: () {
                                controller
                                    .goToItemDetails(controller.results[index]);
                              },
                              splashColor: Colors.pink.withValues(
                                  alpha: 0.2), 
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8), 
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, bottom: 40, right: 4),
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              color: Appcolor.black,
                                              fontFamily: 'Sw',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 92,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Appcolor.mimiPink,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Hero(
                                              tag: controller
                                                  .results[index].itemId!,
                                              child: CachedNetworkImage(
                                                imageUrl: AppLink.itemimage +
                                                    controller.results[index]
                                                        .itemImg!,
                                                height: 85,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${controller.results[index].itemName}"),
                                            Text(
                                              "${controller.results[index].categoryName}",
                                              style: TextStyle(
                                                  fontFamily: "Sw",
                                                  fontSize: 14),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 2),
                                              child: Text(
                                                '\$${controller.results[index].itemPrice!.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontFamily: "Sw",
                                                  color: Appcolor.pink,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(endIndent: 20, indent: 20),
                        ],
                      );
                    },
                  ),
                ],
              )),
        ));
  }
}
