import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/store/home.dart';
import '../../shared/type/blog.dart';
import 'component/item_blog.dart';

const dataFake = [
  {
    "id": 1,
    "title": "How to Kill Mosquitoes: What Works and What Doesn't",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_77d0a89fd60e392be15083a947aadc569e93cb87b1dc139a1fa94fc3bee95cf1.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 2,
    "title": "How to Tell a Bee from a Wasp",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_5566c06f2add49dba85a8ebe7dd87468265713d54d9c860bd8710930413b82b3.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 3,
    "title": "7 Insect Pollinators That Aren't Bees or Butterflies",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_087d5a15bae77f87f8f058afc6030373db1415fe41e7fadb0a6652dfd711ed94.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 4,
    "title":
        "Chelicerates Group: Key Characteristics, Species, and Classifications",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_0f81f20a81f9c55495e91a022badad62277c0928edbaaedac3790c72892952a0.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 5,
    "title": "Do Insects Have Brains?",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_33b971482ba54ab3b6122ffc045b56276e152c6937cd73b85a048ffd64458a06.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 6,
    "title": "What Is the Difference Between Venomous and Poisonous?",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_33fe78ef4ceca2826bbe6e55c67a587f046be2738c36623fd3c600db75d39052.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 7,
    "title": "What Is the Difference Between Venomous and Poisonous?",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_33fe78ef4ceca2826bbe6e55c67a587f046be2738c36623fd3c600db75d39052.jpeg",
    "tags": [],
    "body": null
  },
  {
    "id": 8,
    "title": "What Is the Difference Between Venomous and Poisonous?",
    "image_url":
        "https://main-apps-storage.s3.us-east-2.amazonaws.com/insects/a_img_33fe78ef4ceca2826bbe6e55c67a587f046be2738c36623fd3c600db75d39052.jpeg",
    "tags": [],
    "body": null
  },
];
var jsonString = jsonEncode(dataFake);
List<Blog> articles =
    jsonDecode(jsonString).map<Blog>((item) => Blog.fromJson(item)).toList();

class Home extends StatelessWidget {
  Home({super.key});

  // final homeStore = Get.find<HomeStore>();

  @override
  Widget build(BuildContext context) {
    final homeStore = Get.put(HomeStore());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            homeStore.getBlogFromApi();
            print("Press Home: ${homeStore.arrBlog}");
          },
          child: GetBuilder<HomeStore>(
            init: HomeStore(),
            builder: (_) => Text('Home: ${homeStore.arrBlog.length}'),
          ),
        ),
      ),
      body: ListView(primary: false, children: [
        SizedBox(
          width: width,
          height: height,
          child: GetBuilder<HomeStore>(
            init: HomeStore(),
            builder: (_) => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: homeStore.arrBlog.length + 1,
              itemBuilder: (context, index) {
                return (index == 0
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: ((ItemBlog(
                                width: width, item: homeStore.arrBlog[index]))),
                          ),
                        ],
                      )
                    : (index == homeStore.arrBlog.length
                        ? Container(
                            height: 220,
                          )
                        : (ItemBlog(
                            width: width, item: homeStore.arrBlog[index]))));
              },
            ),
          ),
        ),
      ]),
    );
  }
}
