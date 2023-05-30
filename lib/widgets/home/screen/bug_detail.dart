import 'package:firstgetx/shared/store/home.dart';
import 'package:firstgetx/shared/type/bug.dart';
import 'package:firstgetx/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BugDetail extends StatefulWidget {
  const BugDetail({super.key});

  @override
  State<BugDetail> createState() => _BugDetailState();
}

class _BugDetailState extends State<BugDetail> {
  final homeStore = Get.put(HomeStore());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFF6FAFF),
        body: SafeArea(
            child: Column(children: [
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 18),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset('assets/images/ic_back_circle.png',
                          width: 24, height: 24)))
            ],
          ),
          Expanded(
              child: ListView(children: [
            Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 12),
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
                      ]),
                  child: Image.network(homeStore.currentBugDetail.image_url,
                      width: screenSize.width - 54,
                      height: 228 / 321 * (screenSize.width - 54),
                      fit: BoxFit.cover)),
              Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Column(children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        color: Colors.white,
                        child: Column(children: [
                          Row(children: [
                            Text(homeStore.currentBugDetail.name,
                                style: SafeGoogleFont('Mulish',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5)),
                            InkWell(
                                onTap: () {
                                  _showSimpleModalDialog(context);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    child: Image.asset(
                                        'assets/images/ic_pencil.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover))),
                          ]),
                          Row(children: [
                            Text('Species: ',
                                style: SafeGoogleFont('Mulish',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                    color: const Color(0xFF7B7C81))),
                            Text(homeStore.currentBugDetail.categories[0].name,
                                style: SafeGoogleFont('Mulish',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: const Color(0xFF021A40)))
                          ]),
                          Row(children: [
                            Text('Binomial name: ',
                                style: SafeGoogleFont('Mulish',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                    color: const Color(0xFF7B7C81))),
                            Text(homeStore.currentBugDetail.name,
                                style: SafeGoogleFont('Mulish',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: const Color(0xFF021A40)))
                          ])
                        ])),
                    const SizedBox(height: 12),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GetBuilder<HomeStore>(
                            init: HomeStore(),
                            builder: (_) => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    homeStore.currentBugDetail.article.length,
                                itemBuilder: (context, index) {
                                  if (homeStore
                                      .currentBugDetail.article.isNotEmpty) {
                                    if (homeStore.currentBugDetail
                                            .article[index].type ==
                                        'paragraph') {
                                      return ItemParagraph(
                                          homeStore: homeStore,
                                          item: homeStore
                                              .currentBugDetail.article[index]);
                                    }
                                    if (homeStore.currentBugDetail
                                            .article[index].type ==
                                        'list-item') {
                                      return ItemSubtitle(
                                          homeStore: homeStore,
                                          item: homeStore
                                              .currentBugDetail.article[index]);
                                    }
                                  }
                                  return null;
                                })))
                  ]))
            ])
          ]))
        ])));
  }
}

class ItemParagraph extends StatelessWidget {
  const ItemParagraph({
    super.key,
    required this.homeStore,
    required this.item,
  });

  final HomeStore homeStore;
  final Article item;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        child: Text(item.content,
            textAlign: TextAlign.justify,
            style: SafeGoogleFont('Mulish',
                fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)));
  }
}

class ItemSubtitle extends StatelessWidget {
  const ItemSubtitle({
    super.key,
    required this.homeStore,
    required this.item,
  });

  final Article item;
  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        child: Text('- ${item.content}',
            style: SafeGoogleFont('Mulish',
                fontSize: 16, fontWeight: FontWeight.w400, height: 1.5)));
  }
}

void _showSimpleModalDialog(context) {
  // final screenSize = MediaQuery.of(context).size;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 200),
            child: Container(
              color: const Color(0xFFF6FAF),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 12, right: 8),
                          child: Image.asset(
                            'assets/images/ic_search_home.png',
                            width: 20,
                            height: 20,
                          )),
                      SizedBox(
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
                ],
              ),
            ),
          ),
        );
      });
}
