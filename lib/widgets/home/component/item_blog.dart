import 'package:firstgetx/shared/type/blog.dart';
import 'package:firstgetx/widgets/home/screen/blog_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/store/home.dart';

class ItemBlog extends StatelessWidget {
  ItemBlog({
    super.key,
    required this.width,
    required this.item,
  });

  final homeStore = Get.put(HomeStore());
  final double width;
  final Blog item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await homeStore.getDetailBlog(item.id);
        Get.to(() => const BlogDetailScreen());
      },
      child: Column(
        children: [
          SizedBox(
            width: width - 32,
            height: 108,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: const Offset(-5, -5)),
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: const Offset(5, 5))
                      ],
                    ),
                    width: (303 / 343) * (width - 32),
                    height: 88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 44),
                        Flexible(
                          child: Text(
                            item.title,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                            //Vì fontSize của text là 16, nên lineHeight 24 suy ra height = 24/16 = 1.5
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEE3EF),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                              image: NetworkImage(item.image_url),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
