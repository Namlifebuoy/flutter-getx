import 'package:flutter/material.dart';

import '../../../shared/type/bug.dart';
import '../../../utils/utils.dart';

class ItemListCategory extends StatelessWidget {
  const ItemListCategory({
    super.key,
    required this.item,
  });

  final Bug item;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          width: double.infinity,
          height: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    width: 88,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: const Color(0xFFDEE3EF),
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(44),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.image_url),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 19.5, 12, 19.5),
                    width: screenSize.width - 168,
                    height: double.infinity,
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            child: Text(
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              item.name,
                              style: SafeGoogleFont(
                                'Mulish',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: const Color(0xff021a40),
                              ),
                            ),
                          ),
                          RichText(
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: SafeGoogleFont(
                                'Mulish',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                fontStyle: FontStyle.italic,
                                color: const Color(0xff021a40),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Scientific names: ',
                                  style: SafeGoogleFont(
                                    'Mulish',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xff7a7c80),
                                  ),
                                ),
                                TextSpan(
                                  text: item.name,
                                  style: SafeGoogleFont(
                                    'Mulish',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xff021a40),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/ic_star.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0xffdee2ef),
        ),
      ],
    );
  }
}
