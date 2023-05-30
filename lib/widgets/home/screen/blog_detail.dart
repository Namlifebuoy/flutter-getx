import 'package:firstgetx/shared/store/home.dart';
import 'package:firstgetx/shared/type/blog_detail.dart';
import 'package:firstgetx/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final homeStore = Get.put(HomeStore());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 18),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      'assets/images/ic_back_circle.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(27, 12, 27, 24),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: Offset(-5, -5)),
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ],
                    ),
                    child: Image.network(
                      homeStore.blogDetail.image_url,
                      fit: BoxFit.cover,
                      height: (screenSize.width - 54) * 228 / 321,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      homeStore.blogDetail.title,
                      style: SafeGoogleFont(
                        'Mulish',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                  GetBuilder<HomeStore>(
                    init: HomeStore(),
                    builder: (_) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeStore.blogDetail.body.length,
                        itemBuilder: (context, index) {
                          if (homeStore.blogDetail.body.isNotEmpty) {
                            if (homeStore.blogDetail.body[index].type ==
                                'paragraph') {
                              return ItemParagraph(
                                  homeStore: homeStore,
                                  item: homeStore.blogDetail.body[index]);
                            }
                            if (homeStore.blogDetail.body[index].type ==
                                'subtitle') {
                              return ItemSubtitle(
                                  homeStore: homeStore,
                                  item: homeStore.blogDetail.body[index]);
                            }
                            if (homeStore.blogDetail.body[index].type ==
                                'image') {
                              return ItemImage(
                                  screenSize: screenSize,
                                  item: homeStore.blogDetail.body[index]);
                            }
                          }
                          return null;
                        }),
                  ),
                  // Column(
                  //   children: [
                  //     ItemParagraph(homeStore: homeStore, ),
                  //     ItemSubtitle(homeStore: homeStore),
                  //     ItemImage(screenSize: screenSize),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({
    super.key,
    required this.screenSize,
    required this.item,
  });

  final BodyBlogDetail item;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        color: Colors.amber,
        child: Image.network(
          item.content,
          height: screenSize.width * 248 / 375,
          fit: BoxFit.cover,
        ));
  }
}

class ItemSubtitle extends StatelessWidget {
  const ItemSubtitle({
    super.key,
    required this.homeStore,
    required this.item,
  });

  final BodyBlogDetail item;
  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        item.content,
        style: SafeGoogleFont(
          'Mulish',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
    );
  }
}

class ItemParagraph extends StatelessWidget {
  const ItemParagraph({
    super.key,
    required this.homeStore,
    required this.item,
  });

  final HomeStore homeStore;
  final BodyBlogDetail item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        item.content,
        textAlign: TextAlign.justify,
        style: SafeGoogleFont(
          'Mulish',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }
}
