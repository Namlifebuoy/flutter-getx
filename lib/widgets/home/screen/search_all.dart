import 'dart:async';

import 'package:firstgetx/shared/store/favorite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/store/home.dart';
import '../../../utils/utils.dart';
import '../component/item_list_category.dart';
import 'bug_detail.dart';

class SearchAll extends StatefulWidget {
  const SearchAll({super.key});

  @override
  State<SearchAll> createState() => _SearchAllState();
}

class _SearchAllState extends State<SearchAll> {
  final _textController = TextEditingController();
  Timer searchOnStoppedTyping = Timer(const Duration(days: 365), () {});
  String _text = '';
  final homeStore = Get.put(HomeStore());
  final favoriteStore = Get.put(FavoriteStore());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User is at the bottom
        print("scroll end of list: ${homeStore.isLoading.value}");
        if (homeStore.isLoading.value == true) {
          onEndReached(_text);
          print("page:: ${homeStore.arrSearchAll.items.length}");
        }
      }
    });
  }

  void onEndReached(String text) {
    if (homeStore.isLoadMore.value) {
      homeStore.addPage();
      print("hiha: ${homeStore.countPage.value}");

      homeStore.getSearchAllDetailCategory(homeStore.countPage.value,
          key: text);
    }
  }

  void fetchData(String text) {
    homeStore.isLoadMore.value = true;
    homeStore.countPage.value = 1;
    homeStore.arrSearchAll.items = [];

    const duration = Duration(milliseconds: 500);
    setState(() => searchOnStoppedTyping.cancel());
    setState(
      () => searchOnStoppedTyping = Timer(duration, () {
        homeStore.getSearchAllDetailCategory(homeStore.countPage.value,
            key: text);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  width: screenSize.width - 72 - 16,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(width: 1, color: const Color(0xFFdee3ef))),
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
                        width: screenSize.width -
                            72 -
                            16 -
                            12 * 2 -
                            20 * 2 -
                            8 * 2,
                        height: 21,
                        child: TextField(
                          controller: _textController,
                          onChanged: (text) {
                            setState(() {
                              _text = text;
                            });
                            fetchData(text);
                          },
                          style: SafeGoogleFont(
                            'Mulish',
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Search bugs or insects',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _text = '';
                              _textController.clear();
                            });
                            fetchData(_text);
                          },
                          child: Image.asset(
                            'assets/images/ic_close_search.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Cancel',
                      style: SafeGoogleFont('Mulish',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: const Color(0xFF0E51F3)),
                    ),
                  ),
                ),
              ],
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
                    // const SizedBox(
                    //   height: 14,
                    // ),
                    GetBuilder<HomeStore>(
                      init: HomeStore(),
                      builder: (_) => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeStore.arrSearchAll.items.length,
                          itemBuilder: (context, index) {
                            if (homeStore.arrSearchAll.items.isNotEmpty) {
                              return ItemListCategory(
                                item: homeStore.arrSearchAll.items[index],
                                onPressItem: () async {
                                  await homeStore.getDetailBug(
                                      homeStore.arrSearchAll.items[index].id);
                                  favoriteStore.addToHistory(
                                      homeStore.arrSearchAll.items[index]);
                                  Get.to(() => const BugDetail());
                                },
                                onFavorite: () {
                                  favoriteStore.addToFavorite(
                                      homeStore.arrSearchAll.items[index]);
                                },
                              );
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
