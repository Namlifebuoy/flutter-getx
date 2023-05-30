import 'package:flutter/material.dart';

import '../../../shared/type/bug.dart';
import '../../../utils/utils.dart';

class ItemHistory extends StatelessWidget {
  const ItemHistory({
    super.key,
    required this.onPressItem,
    required this.item,
  });

  final Bug item;
  final Function onPressItem;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onPressItem();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: screenSize.width,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(item.image_url),
                ),
              ),
            ),
            Text(
              item.name,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: SafeGoogleFont(
                'Mulish',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: const Color(0xff021a40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
