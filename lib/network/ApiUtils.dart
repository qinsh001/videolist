import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:videolist/utils/app_utils.dart';
import 'package:videolist/network/x_http_utils.dart';

import '../model/simple_models.dart';

class ApiUtils {
  ///https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323
  static Future<TvboxModel?> getTvBoxData() async {
    final result = await XHttpUtils.get<TvboxModel>(
        "https://gitee.com/andoridityu/files/raw/master/yyy.json");
    return result;
  }

  static Future<List<LiveModel>> getTvBoxData4() async {
    final jsonX = await rootBundle.loadString("assets/json/tv2.txt");
    return AppUtils.parseLiveModel(jsonX);
  }

  static Future<void> getTvBoxData2(String title) async {
    final url =
        "http://api.pullword.com/get.php?source=${Uri.encodeFull(title)}&param1=0&param2=0&json=1";
    final result = await XHttpUtils.get<String>(url);
    print("\n$result");
  }

  static Future<Map<String, dynamic>?> getTvBoxData3(
      String api, String title) async {
    final url = "$api?wd=${Uri.encodeFull(title)}&ac=detail";
    final result = await XHttpUtils.get<Map<String, dynamic>>(url);
    try {
      return result;
    } catch (e) {}
    return null;
  }

  static Future<ListInfoItem2?> getHotData() async {
    //
    final result = await XHttpUtils.get<ListInfoItem2>(
        "https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323");
    return result;
  }

  static Future<List<LiveChannelItem>> getLiveChannelItemS() async {
    final request = await XHttpUtils.get<String>(
        "https://gitlab.com/qinshihuang0011/qsh_files/-/raw/main/tv.txt");
    if (request == null) return [];
    final list = request.trim().split('\n').mapIndexed((index, e) {
      final item = e.split(",");
      return LiveChannelItem(item.first, [item.last], index: index);
    }).toList();
    final infoList = await getEpginfoList();
    list.first.epginfoList = infoList;
    return list;
  }

  static Future<EpginfoList?> getEpginfoList({String name = "CCTV 综合"}) async {
    final request = await XHttpUtils.get<EpginfoList>(
        "https://epg.112114.xyz/?ch=${Uri.encodeFull(name)}&date=2023-11-27");
    return request;
  }
}
