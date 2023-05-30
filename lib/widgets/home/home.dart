import 'package:firstgetx/widgets/home/screen/list_blog.dart';
import 'package:firstgetx/widgets/home/screen/more_category.dart';
import 'package:firstgetx/widgets/home/screen/search_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/store/favorite.dart';
import '../../shared/store/home.dart';
import 'component/item_blog.dart';
import '../../../utils/utils.dart';
import 'component/item_category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final homeStore = Get.put(HomeStore());
    final favoriteStore = Get.put(FavoriteStore());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDEE3EF), width: 1)),
              child: InkWell(
                onTap: () async {
                  await homeStore.getSearchAllDetailCategory(1);
                  homeStore.countPage.value = 1;
                  Get.to(() => const SearchAll());
                },
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 12, right: 8),
                        child: Image.asset(
                          'assets/images/ic_search_home.png',
                          width: 20,
                          height: 20,
                        )),
                    SizedBox(
                        width: 0.8 * screenSize.width,
                        height: 21,
                        child: Text(
                          'Search bugs or insects',
                          style: SafeGoogleFont('Mulish',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              height: 1.5),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: InkWell(
                    onTap: () {
                      // favoriteStore.getDataFromHistory();
                    },
                    child: Image.asset('assets/images/img_banner_ads.png'),
                  ),
                ),
// --------> TitleCategory
                Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 12, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Category',
                                style: SafeGoogleFont(
                                  'Mulish',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                )),
                            InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.to(() => const MoreCategory());
                                },
                                child: Text('See more',
                                    style: SafeGoogleFont(
                                      'Mulish',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF0E51F3),
                                      height: 1.5,
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                const SizedBox(width: 16),
// --------> ItemCategory
                                GetBuilder<HomeStore>(
                                    init: HomeStore(),
                                    builder: (_) => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: homeStore.arrCategory.length,
                                        itemBuilder: (context, index) {
                                          if (homeStore
                                              .arrCategory.isNotEmpty) {
                                            return ItemCategory(
                                                item: homeStore
                                                    .arrCategory[index]);
                                          }
                                          return null;
                                        }))
                              ]))
                    ])),
// --------> ItemBlog
                GetBuilder<HomeStore>(
                  init: HomeStore(),
                  builder: (_) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      if (homeStore.arrBlog.isNotEmpty) {
                        return (index == 0
                            ? Column(children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 24, left: 16, right: 16),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Blog',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                height: 1.5),
                                          ),
                                          InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                Get.to(() => const ListBlog());
                                              },
                                              child: const Text('See more',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xFF0E51F3),
                                                      height: 1.5)))
                                        ])),
                                Container(
                                    margin: const EdgeInsets.only(top: 12),
                                    child: ((ItemBlog(
                                        width: screenSize.width,
                                        item: homeStore.arrBlog[index])))),
                              ])
                            : (ItemBlog(
                                width: screenSize.width,
                                item: homeStore.arrBlog[index])));
                      }
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
