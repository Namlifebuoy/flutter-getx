import 'package:flutter/material.dart';

class AppColors {
  static var black1 = const Color(0xFF000000);
  static var black2 = const Color(0xFF1d1d1d);
  static var white = const Color(0xFFFFFFFF);
  static var orange = const Color(0xFFF68A1D);
  static var orangeSub = const Color(0xFFFFBC25);
  static var green = const Color(0xFF00593C);
  static var greenText = const Color(0xFF005234);
  static var greenTextSocial = const Color(0xFF006830);
  static var red = const Color(0xFFFF3908);
  static var dark = const Color(0xFF191E28);
  static var darkBlue = const Color(0xFF333D50);
  static var blueBlur = const Color(0xFFE5F9F9);
  static var tabbarGray = const Color(0xFF828282);
  static var textGray = const Color(0xFF9695A8);
  static var disableGray = const Color(0xFFBDBDBD);
  static var lightGray = const Color(0xFFF4F4F4);
  static var background = const Color(0xFFFFFFFF);
  static var secondary = const Color(0xFF333E63);
  static var main = const Color(0xFFFF8005);
  static var mainBlur = const Color(0xFFFFF3E2);
  static var mainBold = const Color(0xFFFF3908);
  static var mainIntro = const Color(0xFFFFBDAD);
  static var mainBlur1 = const Color(0xFFFFE9CB);
  static var departmentBg = const Color(0xFFB2BAA7);
  static var itemSearchBg = const Color(0xFFE6E9E0);
}

class AppTextSize {
  static double heading = 24;
  static double large = 18;
  static double medium = 16;
  static double normal = 14;
  static double small = 12;
  static double min = 10;
  static double ipadNormal = 22;
  static double ipadMedium = 30;
}

class Responsive {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

class CommonStyles {
  static Decoration shadowView = BoxDecoration(
    color: AppColors.white,
    borderRadius: const BorderRadius.all(
      Radius.circular(15),
    ),
    border: Border.all(
      color: AppColors.white,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 4,
        offset: const Offset(0, 1),
      )
    ],
  );

  static TextStyle titleStyle = TextStyle(
      fontSize: AppTextSize.medium,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.mainBold);
}
