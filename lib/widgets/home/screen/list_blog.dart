import 'package:firstgetx/widgets/home/component/item_blog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/store/home.dart';
import '../../../utils/utils.dart';

class ListBlog extends StatefulWidget {
  const ListBlog({super.key});

  @override
  State<ListBlog> createState() => _ListBlogState();
}

class _ListBlogState extends State<ListBlog> {
  final homeStore = Get.put(HomeStore());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User is at the bottom
        print("scroll end of list");
        if (homeStore.isLoading.value == true) {
          homeStore.addPage();
          homeStore.getBlogFromApi(homeStore.countPage.value);
          print("page:: ${homeStore.countPage}");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'Blog',
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
                    height: 24,
                  )
                ],
              ),
            ),
            Expanded(
              child: NotificationListener(
                onNotification: (t) {
                  if (t is ScrollEndNotification) {
                    homeStore.isLoading.value = true;
                  }
                  if (t is ScrollStartNotification) {
                    print('hihi: ');
                  }
                  return true;
                },
                child: ListView(
                  controller: _scrollController,
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    GetBuilder<HomeStore>(
                      init: HomeStore(),
                      builder: (_) => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeStore.arrBlog.length,
                          itemBuilder: (context, index) {
                            if (homeStore.arrBlog.isNotEmpty) {
                              return ItemBlog(
                                  width: screenSize.width,
                                  item: homeStore.arrBlog[index]);
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
