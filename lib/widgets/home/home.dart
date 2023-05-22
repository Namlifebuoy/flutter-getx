import 'package:firstgetx/widgets/home/screen/more_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    // const SystemUiOverlayStyle(
    //   statusBarColor: Colors.green, // <-- SEE HERE
    //   statusBarIconBrightness:
    //       Brightness.dark, //<-- For Android SEE HERE (dark icons)
    //   statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
    // );

    final homeStore = Get.put(HomeStore());
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
                border: Border.all(color: const Color(0xFFDEE3EF), width: 1),
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
                    width: 0.8 * screenSize.width,
                    height: 21,
                    child: const TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'Search bugs or insects'),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: InkWell(
                    onTap: () {
                      homeStore.getDetailBlog(1);
                    },
                    child: Image.asset(
                      'assets/images/img_banner_ads.png',
                    ),
                  ),
                ),
// --------> TitleCategory
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 12, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              style: SafeGoogleFont(
                                'Mulish',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                Get.to(() => const MoreCategory());
                              },
                              child: Text(
                                'See more',
                                style: SafeGoogleFont(
                                  'Mulish',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF0E51F3),
                                  height: 1.5,
                                ),
                                // Vì fontSize: 14, nên lineHeight: 21 suy ra height = 21/14 = 1.5
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
// --------> ItemCategory
                            GetBuilder<HomeStore>(
                              init: HomeStore(),
                              builder: (_) => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: homeStore.arrCategory.length,
                                  itemBuilder: (context, index) {
                                    if (homeStore.arrBlog.isNotEmpty) {
                                      return ItemCategory(
                                          item: homeStore.arrCategory[index]);
                                    }
                                    return null;
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
// --------> ItemBlog
                GetBuilder<HomeStore>(
                  init: HomeStore(),
                  builder: (_) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeStore.arrBlog.length + 1,
                    itemBuilder: (context, index) {
                      if (homeStore.arrBlog.isNotEmpty) {
                        return (index == 0
                            ? Column(
                                children: [
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
                                          onTap: () {},
                                          child: const Text(
                                            'See more',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF0E51F3),
                                                height: 1.5),
                                            // Vì fontSize: 14, nên lineHeight: 21 suy ra height = 21/14 = 1.5
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 12),
                                    child: ((ItemBlog(
                                        width: screenSize.width,
                                        item: homeStore.arrBlog[index]))),
                                  ),
                                ],
                              )
                            : (index == homeStore.arrBlog.length
                                ? Container(
                                    height: 20,
                                  )
                                : (ItemBlog(
                                    width: screenSize.width,
                                    item: homeStore.arrBlog[index]))));
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
