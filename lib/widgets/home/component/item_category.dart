import 'package:firstgetx/shared/store/home.dart';
import 'package:firstgetx/widgets/home/screen/list_detail_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/type/category.dart';

import '../../../utils/utils.dart';

class ItemCategory extends StatelessWidget {
  ItemCategory({super.key, required this.item});

  final Category item;
  final HomeStore homeStore = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await homeStore.getDetailCategoryFromApi(item.id);
        Get.to(() => const ListDetailCategory(), arguments: item.name);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        width: 208 / 375 * screenSize.width,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              item.image_url,
              fit: BoxFit.cover,
              width: 208 / 375 * screenSize.width,
              height: 160,
            ),
          ),
          Positioned(
            child: Container(
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
        ]),
      ),
    );
  }
}
