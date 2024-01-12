import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:videolist/utils/app_utils.dart';
import 'package:videolist/network/dio_utils.dart';
import 'package:videolist/network/x_http_utils.dart';
import 'package:videolist/utils/log_extensions.dart';

import '../model/simple_models.dart';

class ApiUtils {
  ///https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323
  static Future<TvboxModel?> getTvBoxData() async {
    final result = await DioUtils.dio.getUri(
        Uri.parse("https://gitee.com/andoridityu/files/raw/master/xxx.json"));
    // final jsonX = await rootBundle.loadString("assets/json/tv_box.json");
    // "jsonX=${jsonX.substring(0, 20)}".log();
    try {
      // final result2 = json.decode(result.data!);
      return TvboxModel.fromJson(result.data!);
    } catch (e) {
      print(e);
    }
  }

  static Future<List<LiveModel>> getTvBoxData4() async {
    final jsonX = await rootBundle.loadString("assets/json/tv2.txt");
    // "jsonX=${jsonX.substring(0, 20)}".log();
    return AppUtils.parseLiveModel(jsonX);
  }

  static Future<void> getTvBoxData2(String title) async {
    final url = "http://api.pullword.com/get.php?source=${Uri.encodeFull(title)}&param1=0&param2=0&json=1";
    final result = await DioUtils.dio.getUri(Uri.parse(url));
    // final jsonX = await rootBundle.loadString("assets/json/tv_box.json");
    // "jsonX=${jsonX.substring(0, 20)}".log();
    try {
      // final result2 = json.decode(result.data!);
      print(url);
      print("\n$result");
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getTvBoxData3(String api,String title) async {
    final url = "$api?wd=${Uri.encodeFull(title)}&ac=detail";
    final result = await DioUtils.dio.getUri(Uri.parse(url));
    // final jsonX = await rootBundle.loadString("assets/json/tv_box.json");
    // "jsonX=${jsonX.substring(0, 20)}".log();
    try {
      // final result2 = json.decode(result.data!);
      if(result.statusCode==200){
        print(url);
        return json.decode(result.data!);
      }
    } catch (e) {
      // print(e);
    }
  }

  static Future<ListInfoItem2> getHotData() async {
    //
    final result = await DioUtils.dio.getUri(Uri.parse(
        "https://node.video.qq.com/x/api/hot_search?channdlId=0&_=1700632980323"));
    return ListInfoItem2.fromJson(json.decode(result.data!));
  }

  static Future<List<LiveChannelItem>> getLiveChannelItemS() async {
    final request = await XHttpUtils.getForFullResponse(
        "https://gitlab.com/qinshihuang0011/qsh_files/-/raw/main/tv.txt");
    //final jsonX = await rootBundle.loadString("assets/json/tv.txt");
    String reply = await request.transform(utf8.decoder).join();
    final list = reply.trim().split('\n').mapIndexed((index, e) {
      final item = e.split(",");
      return LiveChannelItem(item.first, [item.last], index: index);
    }).toList();
    final infoList = await getEpginfoList();
    list.first.epginfoList = infoList;
    return list;
  }

  static Future<EpginfoList> getEpginfoList({String name = "CCTV 综合"}) async {
    final request = await XHttpUtils.getForFullResponse(
        "https://epg.112114.xyz/?ch=${Uri.encodeFull(name)}&date=2023-11-27");
    String reply = await request.transform(utf8.decoder).join();
    Logger().e("reply=$reply");
    final list = EpginfoList.fromJson(json.decode(reply));
    return list;
  }
}
