import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/store/home.dart';
import '../../../utils/utils.dart';
import '../component/item_list_category.dart';

class ListDetailCategory extends StatefulWidget {
  const ListDetailCategory({super.key});

  @override
  State<ListDetailCategory> createState() => _ListDetailCategoryState();
}

class _ListDetailCategoryState extends State<ListDetailCategory> {
  // final TextEditingController _controller = TextEditingController();

  Timer searchOnStoppedTyping = Timer(Duration(days: 365), () {});

  void fetchData(String text, HomeStore homeStore) {
    const duration = Duration(milliseconds: 200);
    // if (searchOnStoppedTyping != null) {
    //   setState(() => searchOnStoppedTyping.cancel()); // clear timer
    // }
    setState(() => searchOnStoppedTyping.cancel());
    setState(
      () => searchOnStoppedTyping = Timer(duration, () {
        homeStore.getDetailCategoryFromApi(homeStore.indexCategory, key: text);
      }),
    );
  }

  String params = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final homeStore = Get.put(HomeStore());
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: screenSize.width - 32,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      'assets/images/ic_back_circle.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        params,
                        style: SafeGoogleFont(
                          'Mulish',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 8),
              height: 45,
              child: Row(
                children: [
                  Container(
                    height: 45,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: const Color(0xFFDEE3EF), width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12, right: 8),
                          child: Image.asset(
                            'assets/images/ic_search_home.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          width: 291 / 375 * screenSize.width + 12,
                          height: 21,
                          child: TextField(
                            onChanged: (text) {
                              fetchData(text, homeStore);
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Search $params',
                              hintStyle: SafeGoogleFont(
                                'Mulish',
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                height: 1.5,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GetBuilder<HomeStore>(
                    init: HomeStore(),
                    builder: (_) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeStore.arrCurrentCategory.length,
                        itemBuilder: (context, index) {
                          if (homeStore.arrCurrentCategory.isNotEmpty) {
                            return ItemListCategory(
                                item: homeStore.arrCurrentCategory[index]);
                          }
                          return null;
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
