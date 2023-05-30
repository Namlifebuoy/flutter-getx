import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../shared/store/home.dart';
import '../../../utils/utils.dart';
import '../component/item_category2.dart';

class MoreCategory extends StatefulWidget {
  const MoreCategory({super.key});

  @override
  State<MoreCategory> createState() => _MoreCategoryState();
}

class _MoreCategoryState extends State<MoreCategory> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final homeStore = Get.put(HomeStore());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
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
                          'Category',
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
            ),
            Expanded(
              child: ListView(
                children: [
                  GetBuilder<HomeStore>(
                    init: HomeStore(),
                    builder: (_) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeStore.arrCategory.length,
                        itemBuilder: (context, index) {
                          if (homeStore.arrCategory.isNotEmpty) {
                            return ItemCategory2(
                                item: homeStore.arrCategory[index]);
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
