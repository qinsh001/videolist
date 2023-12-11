import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:videolist/model/simple_models.dart';
import 'package:xml/xml.dart';

import '../model/xml_models.dart';

class AppUtils {
  static bool isUrl(String url) {
    return url.startsWith("http://") || url.startsWith("https://");
  }

  static String getApiUrl(dynamic api, dynamic ext) {
    if (api != null && isUrl("$api")) {
      return "$api";
    }
    if (ext != null && isUrl("$ext")) {
      return "$ext";
    }
    return "";
  }

  static String getX(XmlDocument xmlDocument, String name,
      {String defaultValue = ""}) {
    final value = xmlDocument.findAllElements(name).single.innerText;
    return value.isEmpty ? defaultValue : value;
  }

  static List<Video> parseXmlToVideo(String xml) {
    final document = XmlDocument.parse(xml);
    final list = document.findAllElements("list");
    final videos2 = <Video>[];
    for (var element in list) {
      final videos = element.findAllElements("dl").first.findAllElements("dd");
      final video = Video(
          last: getX(document, 'last'),
          id: getX(document, 'id'),
          tid: int.parse(getX(document, 'tid', defaultValue: "0")),
          name: getX(document, 'name'),
          type: getX(document, 'type'),
          pic: getX(document, 'pic'),
          lang: getX(document, 'lang'),
          area: getX(document, 'area'),
          year: int.parse(getX(document, 'year', defaultValue: "0")),
          state: getX(document, 'state'),
          note: getX(document, 'note'),
          actor: getX(document, 'actor'),
          director: getX(document, 'director'),
          des: getX(document, 'des'),
          flag: videos.single.getAttribute("flag") ?? "",
          urls: videos.single.innerText,
          sourceKey: '',
          tag: '');
      videos2.add(video);
    }
    return videos2;
  }

  static Future<String> convertM3UToJson(String inputFilePath) async {
    List<String> lines = inputFilePath.trim().split("\n");
    List<Map<String, String>> playlist = [];
    Map<String, String>? currentEntry;
    for (var line in lines) {
      line = line.trim();
      if (line.startsWith('#EXTINF:')) {
        currentEntry = {};
        int commaIndex = line.indexOf(',');
        if (commaIndex != -1) {
          currentEntry['duration'] = line.substring(8, commaIndex);
          currentEntry['title'] = line.substring(commaIndex + 1);
        } else {
          currentEntry['duration'] = line.substring(8);
        }
      } else if (line.isNotEmpty && !line.startsWith('#')) {
        if (currentEntry != null) {
          currentEntry['url'] = line;
          playlist.add(currentEntry);
          currentEntry = null;
        }
      }
    }
    String json = jsonEncode(playlist);
    return json;
    print('Conversion complete. JSON file saved at $json');
  }

  static Future<void> fullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []);
    // 隐藏状态栏和导航栏
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static List<LiveModel> parseLiveModel(String text) {
    final lines = text.trim().split('\n');
    final list = <LiveModel>[];
    LiveModel? model;
    for (final line in lines) {
      if (line.contains('#genre#')) {
        final key = line.split(',').first.trim();
        model = LiveModel(key);
        list.add(model);
      } else {
        final parts = line.split(',');
        final key = parts.first.trim();
        final value = parts.last.trim();
        model?.item.add(LiveModelItem(key, value));
      }
    }
    return list;
  }

  static String getDefaultStr(String? str, {String defaultStr = ""}) {
    if (str != null && str.isNotEmpty) {
      return str;
    } else {
      return defaultStr;
    }
  }

  static bool isJson(String str) {
    try {
      jsonDecode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
  static List<LiveModelItem> getVideoUrls(dynamic vodPlayUrl) {
    if (vodPlayUrl is String &&
        vodPlayUrl.contains("#") &&
        vodPlayUrl.contains("\$")) {
      final parts = vodPlayUrl
          .split("\$\$\$")
          .where((element) => AppUtils.isM3u8(element));
      final items = parts.first.split("#");
      return items.map((e) {
        final parts = e.split("\$");
        return LiveModelItem(parts.first, parts.last.trim());
      }).toList();
    }
    return [];
  }

  static bool isOkPlayUrl(dynamic vodPlayUrl) {
    if (vodPlayUrl is String &&
        vodPlayUrl.contains("#") &&
        vodPlayUrl.contains("\$") &&
        isM3u8(vodPlayUrl)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isM3u8(String url) {
    return url.contains("m3u8");
  }
}
