import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../shared/store/home.dart';
import '../../../shared/type/category.dart';
import '../../../utils/utils.dart';

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

class ItemCategory2 extends StatelessWidget {
  const ItemCategory2({super.key, required this.item});

  final Category item;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Image.network(
                  item.image_url,
                  fit: BoxFit.cover,
                  width: screenSize.width - 32,
                  height: (screenSize.width - 32) * 164 / 343,
                ),
              ),
              Positioned(
                child: Container(
                  width: screenSize.width - 32,
                  height: (screenSize.width - 32) * 164 / 343,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0, -0.556),
                      end: Alignment(0, 1),
                      colors: <Color>[
                        Color.fromRGBO(196, 196, 196, 0),
                        Color.fromRGBO(125, 125, 125, 0.83),
                        Color(0xFF5F5F5F)
                      ],
                      stops: <double>[0.67, 0.88, 0.963],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 12,
                child: Text(
                  item.name,
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
