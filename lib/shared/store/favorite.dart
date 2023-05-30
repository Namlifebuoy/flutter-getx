import 'dart:convert';

import 'package:firstgetx/shared/type/bug.dart';
import 'package:firstgetx/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStore extends GetxController {
  List<Bug> arrHistory = <Bug>[].obs;
  List<Bug> arrFavorite = <Bug>[].obs;
  late SharedPreferences prefs;

  FavoriteStore() {
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    getDataFromHistory();
    getDataFromFavorite();
  }

  addToHistory(Bug item) async {
    int id = arrHistory.indexWhere((element) => element.id == item.id);
    if (id != -1) {
      arrHistory.removeAt(id);
    }
    arrHistory.add(item);
    if (arrHistory.length > 10) {
      arrHistory.removeRange(0, arrHistory.length - 10);
    }
    update();
    String jsonString =
        json.encode(arrHistory.map((bug) => bug.toJson()).toList());
    prefs.setString(BUG_HISTORY, jsonString);
    // print("getDataFromHistory_2: ${jsonString}");
  }

  getDataFromHistory() async {
    final String? data = prefs.getString(BUG_HISTORY);
    if (data != null) {
      List<dynamic> jsonData = jsonDecode(data);
      jsonData.forEach((item) {
        Map<String, dynamic> map = jsonDecode(item);
        Bug bug = Bug.fromJson2(map);
        arrHistory.add(bug);
      });
    }
  }

  addToFavorite(Bug data) {
    int id = arrFavorite.indexWhere((el) => el.id == data.id);
    if (id != -1) {
      arrFavorite.removeAt(id);
    } else {
      arrFavorite.add(data);
    }
    update();
    String jsonString =
        json.encode(arrFavorite.map((data) => data.toJson()).toList());
    prefs.setString(FAVORITE, jsonString);
    print("addToFavorite $jsonString");
  }

  getDataFromFavorite() async {
    final String? data = prefs.getString(FAVORITE);
    if (data != null) {
      List<dynamic> jsonData = jsonDecode(data);
      jsonData.forEach((item) {
        Map<String, dynamic> map = jsonDecode(item);
        Bug bug = Bug.fromJson2(map);
        arrFavorite.add(bug);
      });
    }
  }

  checkFavorite(Bug item) {
    int id = arrFavorite.indexWhere((el) => el.id == item.id);
    if (id == -1) {
      return false;
    } else {
      return true;
    }
  }
}
