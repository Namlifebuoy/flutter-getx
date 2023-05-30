import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/store/home.dart';
import '../../../shared/type/category.dart';
import '../../../utils/utils.dart';
import '../screen/list_detail_category.dart';

class ItemCategory2 extends StatelessWidget {
  const ItemCategory2({super.key, required this.item});

  final Category item;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final homeStore = Get.put(HomeStore());
    return InkWell(
      onTap: () async {
        await homeStore.getDetailCategoryFromApi(item.id);
        Get.to(() => const ListDetailCategory(), arguments: item.name);
      },
      child: Container(
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
        ),
      ),
    );
  }
}
