import 'package:firstgetx/shared/store/favorite.dart';
import 'package:firstgetx/widgets/home/component/item_list_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/store/home.dart';
import '../../utils/utils.dart';
import '../home/screen/bug_detail.dart';
import 'component/item_history.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

final homeStore = Get.put(HomeStore());
final favoriteStore = Get.put(FavoriteStore());

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: screenSize.width - 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Collection',
                        style: SafeGoogleFont('Mulish',
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            height: 1.5)),
                    InkWell(
                        onTap: () {},
                        child: Image.asset(
                            'assets/images/ic_header_collection.png',
                            width: 32,
                            height: 32))
                  ],
                ),
              ),
            ),
            Container(
                height: 45,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFFDEE3EF), width: 1)),
                child: InkWell(
                    onTap: () async {
                      // await homeStore.getSearchAllDetailCategory(1);
                      // homeStore.countPage.value = 1;
                      // Get.to(() => const SearchAll())
                    },
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 12, right: 8),
                            child: Image.asset(
                                'assets/images/ic_search_home.png',
                                width: 20,
                                height: 20)),
                        SizedBox(
                            width: 0.8 * screenSize.width,
                            height: 21,
                            child: Text('Search bugs or insects',
                                style: SafeGoogleFont('Mulish',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5))),
                      ],
                    ))),
            Expanded(
              child: ListView(children: [
                favoriteStore.arrHistory.isNotEmpty
                    ? SizedBox(
                        width: screenSize.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                              child: Text(
                                'History',
                                style: SafeGoogleFont(
                                  'Mulish',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Color(0xff021a40),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width,
                              height: 130,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GetBuilder<FavoriteStore>(
                                      init: FavoriteStore(),
                                      builder: (_) => ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              favoriteStore.arrHistory.length,
                                          itemBuilder: (context, index) {
                                            return ItemHistory(
                                                item: favoriteStore
                                                    .arrHistory[index],
                                                onPressItem: () async {
                                                  await homeStore.getDetailBug(
                                                      favoriteStore
                                                          .arrHistory[index]
                                                          .id);
                                                  Get.to(
                                                      () => const BugDetail());
                                                });
                                          }))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                    width: screenSize.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                            child: Text(
                              'My favorite',
                              style: SafeGoogleFont(
                                'Mulish',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: const Color(0xff021a40),
                              ),
                            ),
                          ),
                          Obx(() => favoriteStore.arrFavorite.isNotEmpty
                              ? GetBuilder<FavoriteStore>(
                                  init: FavoriteStore(),
                                  builder: (_) => ListView.builder(
                                      itemCount:
                                          favoriteStore.arrFavorite.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ItemListCategory(
                                            item: favoriteStore
                                                .arrFavorite[index],
                                            onPressItem: () async {
                                              await homeStore.getDetailBug(
                                                  favoriteStore
                                                      .arrFavorite[index].id);
                                              favoriteStore.addToHistory(
                                                  favoriteStore
                                                      .arrFavorite[index]);
                                              Get.to(() => const BugDetail());
                                            },
                                            onFavorite: () {
                                              favoriteStore.addToFavorite(
                                                  favoriteStore
                                                      .arrFavorite[index]);
                                            });
                                      }))
                              : Center(
                                  child: Column(children: [
                                  const SizedBox(
                                    height: 64,
                                  ),
                                  Image.asset('assets/images/img_empty.png',
                                      width: 72, height: 64),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text('You Have No Collection',
                                      style: SafeGoogleFont('Mulish',
                                          fontSize: 16,
                                          height: 1.5,
                                          color: const Color(0xFF7B7C81),
                                          fontWeight: FontWeight.w400))
                                ])))
                        ]))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
