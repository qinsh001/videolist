import 'package:collection/collection.dart';
import 'package:videolist/model/json_convert_content.dart';

class TvboxModel {
  TvboxModel({
    required this.spider,
    required this.wallpaper,
    required this.lives,
    required this.sites,
    required this.parses,
    required this.flags,
    required this.ijk,
    required this.ads,
  });

  factory TvboxModel.fromJson(Map json) {
    final lives = json['lives'];
    final sites = json['sites'];
    final parses = json['parses'];
    final ijk = json['ijk'];
    return TvboxModel(
      spider: json['spider'],
      wallpaper: json['wallpaper'],
      lives: lives.map<LivesItem>((e) {
        return LivesItem.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
      sites: sites.map<SitesItem>((e) {
        return SitesItem.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
      parses: parses.map<ParsesItem>((e) {
        return ParsesItem.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
      flags: MyJsonConverter.convertListNotNull(json['flags']),
      ijk: ijk.map<IjkItem>((e) {
        return IjkItem.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
      ads: MyJsonConverter.convertListNotNull(json['ads']),
    );
  }

  final dynamic spider;
  final dynamic wallpaper;
  final List<LivesItem> lives;
  final List<SitesItem> sites;
  final List<ParsesItem> parses;
  final List<dynamic> flags;
  final List<IjkItem> ijk;
  final List<dynamic> ads;

  Map<dynamic, dynamic> toJson() {
    return {
      'spider': spider,
      'wallpaper': wallpaper,
      'lives': lives,
      'sites': sites,
      'parses': parses,
      'flags': flags,
      'ijk': ijk,
      'ads': ads,
    };
  }

  TvboxModel copyWith({
    dynamic spider,
    dynamic wallpaper,
    List<LivesItem>? lives,
    List<SitesItem>? sites,
    List<ParsesItem>? parses,
    List<dynamic>? flags,
    List<IjkItem>? ijk,
    List<dynamic>? ads,
  }) {
    return TvboxModel(
      spider: spider ?? this.spider,
      wallpaper: wallpaper ?? this.wallpaper,
      lives: lives ?? this.lives,
      sites: sites ?? this.sites,
      parses: parses ?? this.parses,
      flags: flags ?? this.flags,
      ijk: ijk ?? this.ijk,
      ads: ads ?? this.ads,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvboxModel &&
          runtimeType == other.runtimeType &&
          spider == other.spider &&
          wallpaper == other.wallpaper &&
          const DeepCollectionEquality().equals(lives, other.lives) &&
          const DeepCollectionEquality().equals(sites, other.sites) &&
          const DeepCollectionEquality().equals(parses, other.parses) &&
          const DeepCollectionEquality().equals(flags, other.flags) &&
          const DeepCollectionEquality().equals(ijk, other.ijk) &&
          const DeepCollectionEquality().equals(ads, other.ads);

  @override
  int get hashCode => Object.hashAll([
        spider,
        wallpaper,
        const DeepCollectionEquality().hash(lives),
        const DeepCollectionEquality().hash(sites),
        const DeepCollectionEquality().hash(parses),
        const DeepCollectionEquality().hash(flags),
        const DeepCollectionEquality().hash(ijk),
        const DeepCollectionEquality().hash(ads),
      ]);
}

class LivesItem {
  LivesItem({
    required this.name,
    required this.type,
    required this.url,
    required this.playerType,
    required this.ua,
    required this.epg,
    required this.logo,
  });

  factory LivesItem.fromJson(Map json) {
    return LivesItem(
      name: json['name'],
      type: json['type'],
      url: json['url'],
      playerType: json['playerType'],
      ua: json['ua'],
      epg: json['epg'],
      logo: json['logo'],
    );
  }

  final dynamic name;
  final int type;
  final dynamic url;
  final int playerType;
  final dynamic ua;
  final dynamic epg;
  final dynamic logo;

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'url': url,
      'playerType': playerType,
      'ua': ua,
      'epg': epg,
      'logo': logo,
    };
  }

  LivesItem copyWith({
    dynamic name,
    int? type,
    dynamic url,
    int? playerType,
    dynamic ua,
    dynamic epg,
    dynamic logo,
  }) {
    return LivesItem(
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      playerType: playerType ?? this.playerType,
      ua: ua ?? this.ua,
      epg: epg ?? this.epg,
      logo: logo ?? this.logo,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LivesItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type &&
          url == other.url &&
          playerType == other.playerType &&
          ua == other.ua &&
          epg == other.epg &&
          logo == other.logo;

  @override
  int get hashCode => Object.hashAll([
        name,
        type,
        url,
        playerType,
        ua,
        epg,
        logo,
      ]);
}

class SitesItem {
  SitesItem({
    required this.key,
    required this.name,
    required this.type,
    required this.api,
    required this.searchable,
    required this.quickSearch,
    this.changeable,
    this.ext,
    this.playerType,
    this.timeout,
    this.filterable,
    this.jar,
  });

  factory SitesItem.fromJson(Map json) {
    return SitesItem(
      key: json['key'],
      name: json['name'],
      type: json['type'],
      api: json['api'],
      searchable: json['searchable'],
      quickSearch: json['quickSearch'],
      changeable: json['changeable'],
      ext: json['ext'],
      playerType: json['playerType'],
      timeout: json['timeout'],
      filterable: json['filterable'],
      jar: json['jar'],
    );
  }

  final dynamic key;
  final dynamic name;
  final int type;
  final dynamic api;
  final int searchable;
  final int quickSearch;
  final int? changeable;
  final dynamic ext;
  final dynamic playerType;
  final int? timeout;
  final int? filterable;
  final dynamic jar;

  Map<dynamic, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'type': type,
      'api': api,
      'searchable': searchable,
      'quickSearch': quickSearch,
      'changeable': changeable,
      'ext': ext,
      'playerType': playerType,
      'timeout': timeout,
      'filterable': filterable,
      'jar': jar,
    };
  }

  SitesItem copyWith({
    dynamic key,
    dynamic name,
    int? type,
    dynamic api,
    int? searchable,
    int? quickSearch,
    int? changeable,
    dynamic ext,
    dynamic playerType,
    int? timeout,
    int? filterable,
    dynamic jar,
  }) {
    return SitesItem(
      key: key ?? this.key,
      name: name ?? this.name,
      type: type ?? this.type,
      api: api ?? this.api,
      searchable: searchable ?? this.searchable,
      quickSearch: quickSearch ?? this.quickSearch,
      changeable: changeable ?? this.changeable,
      ext: ext ?? this.ext,
      playerType: playerType ?? this.playerType,
      timeout: timeout ?? this.timeout,
      filterable: filterable ?? this.filterable,
      jar: jar ?? this.jar,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SitesItem &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          type == other.type &&
          api == other.api &&
          searchable == other.searchable &&
          quickSearch == other.quickSearch &&
          changeable == other.changeable &&
          ext == other.ext &&
          playerType == other.playerType &&
          timeout == other.timeout &&
          filterable == other.filterable &&
          jar == other.jar;

  @override
  int get hashCode => Object.hashAll([
        key,
        name,
        type,
        api,
        searchable,
        quickSearch,
        changeable,
        ext,
        playerType,
        timeout,
        filterable,
        jar,
      ]);
}

class ParsesItem {
  ParsesItem({
    required this.name,
    required this.type,
    required this.url,
    this.ext,
  });

  factory ParsesItem.fromJson(Map json) {
    final ext = json['ext'];
    return ParsesItem(
      name: json['name'],
      type: json['type'],
      url: json['url'],
      ext: ext is Map
          ? ParsesItemExt.fromJson(
              ext as Map<dynamic, dynamic>,
            )
          : null,
    );
  }

  final dynamic name;
  final int type;
  final dynamic url;
  final ParsesItemExt? ext;

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'url': url,
      'ext': ext,
    };
  }

  ParsesItem copyWith({
    dynamic name,
    int? type,
    dynamic url,
    ParsesItemExt? ext,
  }) {
    return ParsesItem(
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      ext: ext ?? this.ext,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParsesItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type &&
          url == other.url &&
          ext == other.ext;

  @override
  int get hashCode => Object.hashAll([
        name,
        type,
        url,
        ext,
      ]);
}

class ParsesItemExt {
  ParsesItemExt({
    required this.flag,
    this.header,
  });

  factory ParsesItemExt.fromJson(Map json) {
    final header = json['header'];
    return ParsesItemExt(
      flag: MyJsonConverter.convertListNotNull(json['flag']),
      header: header is Map
          ? ParsesItemExtHeader.fromJson(
              header as Map<dynamic, dynamic>,
            )
          : null,
    );
  }

  final List<dynamic> flag;
  final ParsesItemExtHeader? header;

  Map<dynamic, dynamic> toJson() {
    return {
      'flag': flag,
      'header': header,
    };
  }

  ParsesItemExt copyWith({
    List<dynamic>? flag,
    ParsesItemExtHeader? header,
  }) {
    return ParsesItemExt(
      flag: flag ?? this.flag,
      header: header ?? this.header,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParsesItemExt &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(flag, other.flag) &&
          header == other.header;

  @override
  int get hashCode => Object.hashAll([
        const DeepCollectionEquality().hash(flag),
        header,
      ]);
}

class ParsesItemExtHeader {
  ParsesItemExtHeader({
    required this.userAgent,
  });

  factory ParsesItemExtHeader.fromJson(Map json) {
    return ParsesItemExtHeader(
      userAgent: json['User-Agent'],
    );
  }

  final dynamic userAgent;

  Map<dynamic, dynamic> toJson() {
    return {
      'User-Agent': userAgent,
    };
  }

  ParsesItemExtHeader copyWith({
    dynamic userAgent,
  }) {
    return ParsesItemExtHeader(
      userAgent: userAgent ?? this.userAgent,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParsesItemExtHeader &&
          runtimeType == other.runtimeType &&
          userAgent == other.userAgent;

  @override
  int get hashCode => Object.hashAll([
        userAgent,
      ]);
}

class IjkItem {
  IjkItem({
    required this.group,
    required this.options,
  });

  factory IjkItem.fromJson(Map json) {
    final options = json['options'];
    return IjkItem(
      group: json['group'],
      options: options.map<IjkItemOptionsItem>((e) {
        return IjkItemOptionsItem.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
    );
  }

  final dynamic group;
  final List<IjkItemOptionsItem> options;

  Map<dynamic, dynamic> toJson() {
    return {
      'group': group,
      'options': options,
    };
  }

  IjkItem copyWith({
    dynamic group,
    List<IjkItemOptionsItem>? options,
  }) {
    return IjkItem(
      group: group ?? this.group,
      options: options ?? this.options,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IjkItem &&
          runtimeType == other.runtimeType &&
          group == other.group &&
          const DeepCollectionEquality().equals(options, other.options);

  @override
  int get hashCode => Object.hashAll([
        group,
        const DeepCollectionEquality().hash(options),
      ]);
}

class IjkItemOptionsItem {
  IjkItemOptionsItem({
    required this.category,
    required this.name,
    required this.value,
  });

  factory IjkItemOptionsItem.fromJson(Map json) {
    return IjkItemOptionsItem(
      category: json['category'],
      name: json['name'],
      value: json['value'],
    );
  }

  final int category;
  final dynamic name;
  final dynamic value;

  Map<dynamic, dynamic> toJson() {
    return {
      'category': category,
      'name': name,
      'value': value,
    };
  }

  IjkItemOptionsItem copyWith({
    int? category,
    dynamic name,
    dynamic value,
  }) {
    return IjkItemOptionsItem(
      category: category ?? this.category,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IjkItemOptionsItem &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => Object.hashAll([
        category,
        name,
        value,
      ]);
}

class MapResultItem {
  MapResultItem({
    required this.channelTitle,
    required this.areaTitle,
    required this.modifyTime,
    required this.listInfo,
    required this.hasNextPage,
  });

  factory MapResultItem.fromJson(Map json) {
    final listInfo = json['listInfo'];
    return MapResultItem(
      channelTitle: json['channelTitle'],
      areaTitle: json['areaTitle'],
      modifyTime: json['modifyTime'],
      listInfo: listInfo.map<ListInfoItem>((e) {
        return ListInfoItem.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
      hasNextPage: json['hasNextPage'],
    );
  }

  final dynamic channelTitle;
  final dynamic areaTitle;
  final dynamic modifyTime;
  final List<ListInfoItem> listInfo;
  final bool hasNextPage;

  Map<dynamic, dynamic> toJson() {
    return {
      'channelTitle': channelTitle,
      'areaTitle': areaTitle,
      'modifyTime': modifyTime,
      'listInfo': listInfo,
      'hasNextPage': hasNextPage,
    };
  }

  MapResultItem copyWith({
    dynamic channelTitle,
    dynamic areaTitle,
    dynamic modifyTime,
    List<ListInfoItem>? listInfo,
    bool? hasNextPage,
  }) {
    return MapResultItem(
      channelTitle: channelTitle ?? this.channelTitle,
      areaTitle: areaTitle ?? this.areaTitle,
      modifyTime: modifyTime ?? this.modifyTime,
      listInfo: listInfo ?? this.listInfo,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapResultItem &&
          runtimeType == other.runtimeType &&
          channelTitle == other.channelTitle &&
          areaTitle == other.areaTitle &&
          modifyTime == other.modifyTime &&
          const DeepCollectionEquality().equals(listInfo, other.listInfo) &&
          hasNextPage == other.hasNextPage;

  @override
  int get hashCode => Object.hashAll([
        channelTitle,
        areaTitle,
        modifyTime,
        const DeepCollectionEquality().hash(listInfo),
        hasNextPage,
      ]);
}

class ListInfoItem {
  ListInfoItem({
    required this.rankNum,
    required this.title,
    required this.hotLevel,
    required this.trend,
    required this.labelList,
    required this.id,
    required this.dataType,
    required this.mark,
  });

  factory ListInfoItem.fromJson(Map json) {
    return ListInfoItem(
      rankNum: json['rankNum'],
      title: json['title'],
      hotLevel: json['hotLevel'],
      trend: json['trend'],
      labelList: json['labelList'],
      id: json['id'],
      dataType: json['dataType'],
      mark: json['mark'],
    );
  }

  final int rankNum;
  final dynamic title;
  final int hotLevel;
  final int trend;
  final List<dynamic> labelList;
  final dynamic id;
  final int dataType;
  final dynamic mark;

  Map<dynamic, dynamic> toJson() {
    return {
      'rankNum': rankNum,
      'title': title,
      'hotLevel': hotLevel,
      'trend': trend,
      'labelList': labelList,
      'id': id,
      'dataType': dataType,
      'mark': mark,
    };
  }

  ListInfoItem copyWith({
    int? rankNum,
    dynamic title,
    int? hotLevel,
    int? trend,
    List<dynamic>? labelList,
    dynamic id,
    int? dataType,
    dynamic mark,
  }) {
    return ListInfoItem(
      rankNum: rankNum ?? this.rankNum,
      title: title ?? this.title,
      hotLevel: hotLevel ?? this.hotLevel,
      trend: trend ?? this.trend,
      labelList: labelList ?? this.labelList,
      id: id ?? this.id,
      dataType: dataType ?? this.dataType,
      mark: mark ?? this.mark,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListInfoItem &&
          runtimeType == other.runtimeType &&
          rankNum == other.rankNum &&
          title == other.title &&
          hotLevel == other.hotLevel &&
          trend == other.trend &&
          const DeepCollectionEquality().equals(labelList, other.labelList) &&
          id == other.id &&
          dataType == other.dataType &&
          mark == other.mark;

  @override
  int get hashCode => Object.hashAll([
        rankNum,
        title,
        hotLevel,
        trend,
        const DeepCollectionEquality().hash(labelList),
        id,
        dataType,
        mark,
      ]);
}

class HotDataModel {
  HotDataModel({
    required this.errCode,
    required this.msg,
    required this.mapResult,
  });

  factory HotDataModel.fromJson(Map json) {
    final mapResult = json['mapResult'];
    final list = <MapResultItem>[];
    if (mapResult is Map) {
      for (var key in mapResult.keys) {
        list.add(MapResultItem.fromJson(mapResult[key]));
      }
    }
    return HotDataModel(
      errCode: json['errCode'],
      msg: json['msg'],
      mapResult: list,
    );
  }

  final int errCode;
  final dynamic msg;
  final List<MapResultItem> mapResult;

  Map<dynamic, dynamic> toJson() {
    return {
      'errCode': errCode,
      'msg': msg,
      'mapResult': mapResult,
    };
  }

  HotDataModel copyWith({
    int? errCode,
    dynamic msg,
    List<MapResultItem>? mapResult,
  }) {
    return HotDataModel(
      errCode: errCode ?? this.errCode,
      msg: msg ?? this.msg,
      mapResult: mapResult ?? this.mapResult,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotDataModel &&
          runtimeType == other.runtimeType &&
          errCode == other.errCode &&
          msg == other.msg &&
          mapResult == other.mapResult;

  @override
  int get hashCode => Object.hashAll([
        errCode,
        msg,
        mapResult,
      ]);
}

class DataMapResult {
  DataMapResult();

  factory DataMapResult.fromJson(Map json) {
    return DataMapResult();
  }

  Map<dynamic, dynamic> toJson() {
    return {};
  }
}

class ListInfoItem2 {
  ListInfoItem2({
    required this.data,
    required this.businessHead,
    required this.ret,
  });

  factory ListInfoItem2.fromJson(Map json) {
    final data = json['data'];
    final businessHead = json['businessHead'];
    return ListInfoItem2(
      data: HotDataModel.fromJson(
        data as Map<dynamic, dynamic>,
      ),
      businessHead: BusinessHead.fromJson(
        businessHead as Map<dynamic, dynamic>,
      ),
      ret: json['ret'],
    );
  }

  final HotDataModel data;
  final BusinessHead businessHead;
  final int ret;

  Map<dynamic, dynamic> toJson() {
    return {
      'data': data,
      'businessHead': businessHead,
      'ret': ret,
    };
  }

  ListInfoItem2 copyWith({
    HotDataModel? data,
    BusinessHead? businessHead,
    int? ret,
  }) {
    return ListInfoItem2(
      data: data ?? this.data,
      businessHead: businessHead ?? this.businessHead,
      ret: ret ?? this.ret,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListInfoItem2 &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          businessHead == other.businessHead &&
          ret == other.ret;

  @override
  int get hashCode => Object.hashAll([
        data,
        businessHead,
        ret,
      ]);
}

class BusinessHead {
  BusinessHead({
    required this.type,
    required this.body,
  });

  factory BusinessHead.fromJson(Map json) {
    return BusinessHead(
      type: json['type'],
      body: json['body'],
    );
  }

  final int type;
  final dynamic body;

  Map<dynamic, dynamic> toJson() {
    return {
      'type': type,
      'body': body,
    };
  }

  BusinessHead copyWith({
    int? type,
    dynamic body,
  }) {
    return BusinessHead(
      type: type ?? this.type,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessHead &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          body == other.body;

  @override
  int get hashCode => Object.hashAll([
        type,
        body,
      ]);
}

class VideoJson {
  VideoJson({
    required this.code,
    required this.msg,
    required this.page,
    required this.pagecount,
    required this.limit,
    required this.total,
    required this.list,
  });

  factory VideoJson.fromJson(Map json) {
    final list = json['list'];
    return VideoJson(
      code: json['code'],
      msg: json['msg'],
      page: json['page'],
      pagecount: json['pagecount'],
      limit: json['limit'],
      total: json['total'],
      list: list.map<ListItemJson>((e) {
        return ListItemJson.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
    );
  }

  final int code;
  final dynamic msg;
  final int page;
  final int pagecount;
  final dynamic limit;
  final int total;
  final List<ListItemJson> list;

  Map<dynamic, dynamic> toJson() {
    return {
      'code': code,
      'msg': msg,
      'page': page,
      'pagecount': pagecount,
      'limit': limit,
      'total': total,
      'list': list,
    };
  }

  VideoJson copyWith({
    int? code,
    dynamic msg,
    int? page,
    int? pagecount,
    dynamic limit,
    int? total,
    List<ListItemJson>? list,
  }) {
    return VideoJson(
      code: code ?? this.code,
      msg: msg ?? this.msg,
      page: page ?? this.page,
      pagecount: pagecount ?? this.pagecount,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      list: list ?? this.list,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoJson &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          msg == other.msg &&
          page == other.page &&
          pagecount == other.pagecount &&
          limit == other.limit &&
          total == other.total &&
          const DeepCollectionEquality().equals(list, other.list);

  @override
  int get hashCode => Object.hashAll([
        code,
        msg,
        page,
        pagecount,
        limit,
        total,
        const DeepCollectionEquality().hash(list),
      ]);
}

class ListItemJson {
  ListItemJson({
    required this.vodId,
    required this.typeId,
    required this.typeId1,
    required this.groupId,
    required this.vodName,
    required this.vodSub,
    required this.vodEn,
    required this.vodStatus,
    required this.vodLetter,
    required this.vodColor,
    required this.vodTag,
    required this.vodClass,
    required this.vodPic,
    required this.vodPicThumb,
    required this.vodPicSlide,
    required this.vodActor,
    required this.vodDirector,
    required this.vodWriter,
    required this.vodBehind,
    required this.vodBlurb,
    required this.vodRemarks,
    required this.vodPubdate,
    required this.vodTotal,
    required this.vodSerial,
    required this.vodTv,
    required this.vodWeekday,
    required this.vodArea,
    required this.vodLang,
    required this.vodYear,
    required this.vodVersion,
    required this.vodState,
    required this.vodAuthor,
    required this.vodJumpurl,
    required this.vodTpl,
    required this.vodTplPlay,
    required this.vodTplDown,
    required this.vodIsend,
    required this.vodLock,
    required this.vodLevel,
    required this.vodCopyright,
    required this.vodPoints,
    required this.vodPointsPlay,
    required this.vodPointsDown,
    required this.vodHits,
    required this.vodHitsDay,
    required this.vodHitsWeek,
    required this.vodHitsMonth,
    required this.vodDuration,
    required this.vodUp,
    required this.vodDown,
    required this.vodScore,
    required this.vodScoreAll,
    required this.vodScoreNum,
    required this.vodTime,
    required this.vodTimeAdd,
    required this.vodTimeHits,
    required this.vodTimeMake,
    required this.vodTrysee,
    required this.vodDoubanId,
    required this.vodDoubanScore,
    required this.vodReurl,
    required this.vodRelVod,
    required this.vodRelArt,
    required this.vodPwd,
    required this.vodPwdUrl,
    required this.vodPwdPlay,
    required this.vodPwdPlayUrl,
    required this.vodPwdDown,
    required this.vodPwdDownUrl,
    required this.vodContent,
    required this.vodPlayFrom,
    required this.vodPlayServer,
    required this.vodPlayNote,
    required this.vodPlayUrl,
    required this.vodDownFrom,
    required this.vodDownServer,
    required this.vodDownNote,
    required this.vodDownUrl,
    required this.vodPlot,
    required this.vodPlotName,
    required this.vodPlotDetail,
    required this.vodPicScreenshot,
    required this.typeName,
  });

  factory ListItemJson.fromJson(Map json) {
    return ListItemJson(
      vodId: json['vod_id'],
      typeId: json['type_id'],
      typeId1: json['type_id_1'],
      groupId: json['group_id'],
      vodName: json['vod_name'],
      vodSub: json['vod_sub'],
      vodEn: json['vod_en'],
      vodStatus: json['vod_status'],
      vodLetter: json['vod_letter'],
      vodColor: json['vod_color'],
      vodTag: json['vod_tag'],
      vodClass: json['vod_class'],
      vodPic: json['vod_pic'],
      vodPicThumb: json['vod_pic_thumb'],
      vodPicSlide: json['vod_pic_slide'],
      vodActor: json['vod_actor'],
      vodDirector: json['vod_director'],
      vodWriter: json['vod_writer'],
      vodBehind: json['vod_behind'],
      vodBlurb: json['vod_blurb'],
      vodRemarks: json['vod_remarks'],
      vodPubdate: json['vod_pubdate'],
      vodTotal: json['vod_total'],
      vodSerial: json['vod_serial'],
      vodTv: json['vod_tv'],
      vodWeekday: json['vod_weekday'],
      vodArea: json['vod_area'],
      vodLang: json['vod_lang'],
      vodYear: json['vod_year'],
      vodVersion: json['vod_version'],
      vodState: json['vod_state'],
      vodAuthor: json['vod_author'],
      vodJumpurl: json['vod_jumpurl'],
      vodTpl: json['vod_tpl'],
      vodTplPlay: json['vod_tpl_play'],
      vodTplDown: json['vod_tpl_down'],
      vodIsend: json['vod_isend'],
      vodLock: json['vod_lock'],
      vodLevel: json['vod_level'],
      vodCopyright: json['vod_copyright'],
      vodPoints: json['vod_points'],
      vodPointsPlay: json['vod_points_play'],
      vodPointsDown: json['vod_points_down'],
      vodHits: json['vod_hits'],
      vodHitsDay: json['vod_hits_day'],
      vodHitsWeek: json['vod_hits_week'],
      vodHitsMonth: json['vod_hits_month'],
      vodDuration: json['vod_duration'],
      vodUp: json['vod_up'],
      vodDown: json['vod_down'],
      vodScore: json['vod_score'],
      vodScoreAll: json['vod_score_all'],
      vodScoreNum: json['vod_score_num'],
      vodTime: json['vod_time'],
      vodTimeAdd: json['vod_time_add'],
      vodTimeHits: json['vod_time_hits'],
      vodTimeMake: json['vod_time_make'],
      vodTrysee: json['vod_trysee'],
      vodDoubanId: json['vod_douban_id'],
      vodDoubanScore: json['vod_douban_score'],
      vodReurl: json['vod_reurl'],
      vodRelVod: json['vod_rel_vod'],
      vodRelArt: json['vod_rel_art'],
      vodPwd: json['vod_pwd'],
      vodPwdUrl: json['vod_pwd_url'],
      vodPwdPlay: json['vod_pwd_play'],
      vodPwdPlayUrl: json['vod_pwd_play_url'],
      vodPwdDown: json['vod_pwd_down'],
      vodPwdDownUrl: json['vod_pwd_down_url'],
      vodContent: json['vod_content'],
      vodPlayFrom: json['vod_play_from'],
      vodPlayServer: json['vod_play_server'],
      vodPlayNote: json['vod_play_note'],
      vodPlayUrl: json['vod_play_url'],
      vodDownFrom: json['vod_down_from'],
      vodDownServer: json['vod_down_server'],
      vodDownNote: json['vod_down_note'],
      vodDownUrl: json['vod_down_url'],
      vodPlot: json['vod_plot'],
      vodPlotName: json['vod_plot_name'],
      vodPlotDetail: json['vod_plot_detail'],
      vodPicScreenshot: json['vod_pic_screenshot'],
      typeName: json['type_name'],
    );
  }

  final int vodId;
  final int typeId;
  final int typeId1;
  final int groupId;
  final dynamic vodName;
  final dynamic vodSub;
  final dynamic vodEn;
  final int vodStatus;
  final dynamic vodLetter;
  final dynamic vodColor;
  final dynamic vodTag;
  final dynamic vodClass;
  final dynamic vodPic;
  final dynamic vodPicThumb;
  final dynamic vodPicSlide;
  final dynamic vodActor;
  final dynamic vodDirector;
  final dynamic vodWriter;
  final dynamic vodBehind;
  final dynamic vodBlurb;
  final dynamic vodRemarks;
  final dynamic vodPubdate;
  final int vodTotal;
  final dynamic vodSerial;
  final dynamic vodTv;
  final dynamic vodWeekday;
  final dynamic vodArea;
  final dynamic vodLang;
  final dynamic vodYear;
  final dynamic vodVersion;
  final dynamic vodState;
  final dynamic vodAuthor;
  final dynamic vodJumpurl;
  final dynamic vodTpl;
  final dynamic vodTplPlay;
  final dynamic vodTplDown;
  final int vodIsend;
  final int vodLock;
  final int vodLevel;
  final int vodCopyright;
  final int vodPoints;
  final int vodPointsPlay;
  final int vodPointsDown;
  final int vodHits;
  final int vodHitsDay;
  final int vodHitsWeek;
  final int vodHitsMonth;
  final dynamic vodDuration;
  final int vodUp;
  final int vodDown;
  final dynamic vodScore;
  final int vodScoreAll;
  final int vodScoreNum;
  final dynamic vodTime;
  final int vodTimeAdd;
  final int vodTimeHits;
  final int vodTimeMake;
  final int vodTrysee;
  final int vodDoubanId;
  final dynamic vodDoubanScore;
  final dynamic vodReurl;
  final dynamic vodRelVod;
  final dynamic vodRelArt;
  final dynamic vodPwd;
  final dynamic vodPwdUrl;
  final dynamic vodPwdPlay;
  final dynamic vodPwdPlayUrl;
  final dynamic vodPwdDown;
  final dynamic vodPwdDownUrl;
  final dynamic vodContent;
  final dynamic vodPlayFrom;
  final dynamic vodPlayServer;
  final dynamic vodPlayNote;
  final dynamic vodPlayUrl;
  final dynamic vodDownFrom;
  final dynamic vodDownServer;
  final dynamic vodDownNote;
  final dynamic vodDownUrl;
  final int vodPlot;
  final dynamic vodPlotName;
  final dynamic vodPlotDetail;
  final dynamic vodPicScreenshot;
  final dynamic typeName;

  Map<dynamic, dynamic> toJson() {
    return {
      'vod_id': vodId,
      'type_id': typeId,
      'type_id_1': typeId1,
      'group_id': groupId,
      'vod_name': vodName,
      'vod_sub': vodSub,
      'vod_en': vodEn,
      'vod_status': vodStatus,
      'vod_letter': vodLetter,
      'vod_color': vodColor,
      'vod_tag': vodTag,
      'vod_class': vodClass,
      'vod_pic': vodPic,
      'vod_pic_thumb': vodPicThumb,
      'vod_pic_slide': vodPicSlide,
      'vod_actor': vodActor,
      'vod_director': vodDirector,
      'vod_writer': vodWriter,
      'vod_behind': vodBehind,
      'vod_blurb': vodBlurb,
      'vod_remarks': vodRemarks,
      'vod_pubdate': vodPubdate,
      'vod_total': vodTotal,
      'vod_serial': vodSerial,
      'vod_tv': vodTv,
      'vod_weekday': vodWeekday,
      'vod_area': vodArea,
      'vod_lang': vodLang,
      'vod_year': vodYear,
      'vod_version': vodVersion,
      'vod_state': vodState,
      'vod_author': vodAuthor,
      'vod_jumpurl': vodJumpurl,
      'vod_tpl': vodTpl,
      'vod_tpl_play': vodTplPlay,
      'vod_tpl_down': vodTplDown,
      'vod_isend': vodIsend,
      'vod_lock': vodLock,
      'vod_level': vodLevel,
      'vod_copyright': vodCopyright,
      'vod_points': vodPoints,
      'vod_points_play': vodPointsPlay,
      'vod_points_down': vodPointsDown,
      'vod_hits': vodHits,
      'vod_hits_day': vodHitsDay,
      'vod_hits_week': vodHitsWeek,
      'vod_hits_month': vodHitsMonth,
      'vod_duration': vodDuration,
      'vod_up': vodUp,
      'vod_down': vodDown,
      'vod_score': vodScore,
      'vod_score_all': vodScoreAll,
      'vod_score_num': vodScoreNum,
      'vod_time': vodTime,
      'vod_time_add': vodTimeAdd,
      'vod_time_hits': vodTimeHits,
      'vod_time_make': vodTimeMake,
      'vod_trysee': vodTrysee,
      'vod_douban_id': vodDoubanId,
      'vod_douban_score': vodDoubanScore,
      'vod_reurl': vodReurl,
      'vod_rel_vod': vodRelVod,
      'vod_rel_art': vodRelArt,
      'vod_pwd': vodPwd,
      'vod_pwd_url': vodPwdUrl,
      'vod_pwd_play': vodPwdPlay,
      'vod_pwd_play_url': vodPwdPlayUrl,
      'vod_pwd_down': vodPwdDown,
      'vod_pwd_down_url': vodPwdDownUrl,
      'vod_content': vodContent,
      'vod_play_from': vodPlayFrom,
      'vod_play_server': vodPlayServer,
      'vod_play_note': vodPlayNote,
      'vod_play_url': vodPlayUrl,
      'vod_down_from': vodDownFrom,
      'vod_down_server': vodDownServer,
      'vod_down_note': vodDownNote,
      'vod_down_url': vodDownUrl,
      'vod_plot': vodPlot,
      'vod_plot_name': vodPlotName,
      'vod_plot_detail': vodPlotDetail,
      'vod_pic_screenshot': vodPicScreenshot,
      'type_name': typeName,
    };
  }

  ListItemJson copyWith({
    int? vodId,
    int? typeId,
    int? typeId1,
    int? groupId,
    dynamic vodName,
    dynamic vodSub,
    dynamic vodEn,
    int? vodStatus,
    dynamic vodLetter,
    dynamic vodColor,
    dynamic vodTag,
    dynamic vodClass,
    dynamic vodPic,
    dynamic vodPicThumb,
    dynamic vodPicSlide,
    dynamic vodActor,
    dynamic vodDirector,
    dynamic vodWriter,
    dynamic vodBehind,
    dynamic vodBlurb,
    dynamic vodRemarks,
    dynamic vodPubdate,
    int? vodTotal,
    dynamic vodSerial,
    dynamic vodTv,
    dynamic vodWeekday,
    dynamic vodArea,
    dynamic vodLang,
    dynamic vodYear,
    dynamic vodVersion,
    dynamic vodState,
    dynamic vodAuthor,
    dynamic vodJumpurl,
    dynamic vodTpl,
    dynamic vodTplPlay,
    dynamic vodTplDown,
    int? vodIsend,
    int? vodLock,
    int? vodLevel,
    int? vodCopyright,
    int? vodPoints,
    int? vodPointsPlay,
    int? vodPointsDown,
    int? vodHits,
    int? vodHitsDay,
    int? vodHitsWeek,
    int? vodHitsMonth,
    dynamic vodDuration,
    int? vodUp,
    int? vodDown,
    dynamic vodScore,
    int? vodScoreAll,
    int? vodScoreNum,
    dynamic vodTime,
    int? vodTimeAdd,
    int? vodTimeHits,
    int? vodTimeMake,
    int? vodTrysee,
    int? vodDoubanId,
    dynamic vodDoubanScore,
    dynamic vodReurl,
    dynamic vodRelVod,
    dynamic vodRelArt,
    dynamic vodPwd,
    dynamic vodPwdUrl,
    dynamic vodPwdPlay,
    dynamic vodPwdPlayUrl,
    dynamic vodPwdDown,
    dynamic vodPwdDownUrl,
    dynamic vodContent,
    dynamic vodPlayFrom,
    dynamic vodPlayServer,
    dynamic vodPlayNote,
    dynamic vodPlayUrl,
    dynamic vodDownFrom,
    dynamic vodDownServer,
    dynamic vodDownNote,
    dynamic vodDownUrl,
    int? vodPlot,
    dynamic vodPlotName,
    dynamic vodPlotDetail,
    dynamic vodPicScreenshot,
    dynamic typeName,
  }) {
    return ListItemJson(
      vodId: vodId ?? this.vodId,
      typeId: typeId ?? this.typeId,
      typeId1: typeId1 ?? this.typeId1,
      groupId: groupId ?? this.groupId,
      vodName: vodName ?? this.vodName,
      vodSub: vodSub ?? this.vodSub,
      vodEn: vodEn ?? this.vodEn,
      vodStatus: vodStatus ?? this.vodStatus,
      vodLetter: vodLetter ?? this.vodLetter,
      vodColor: vodColor ?? this.vodColor,
      vodTag: vodTag ?? this.vodTag,
      vodClass: vodClass ?? this.vodClass,
      vodPic: vodPic ?? this.vodPic,
      vodPicThumb: vodPicThumb ?? this.vodPicThumb,
      vodPicSlide: vodPicSlide ?? this.vodPicSlide,
      vodActor: vodActor ?? this.vodActor,
      vodDirector: vodDirector ?? this.vodDirector,
      vodWriter: vodWriter ?? this.vodWriter,
      vodBehind: vodBehind ?? this.vodBehind,
      vodBlurb: vodBlurb ?? this.vodBlurb,
      vodRemarks: vodRemarks ?? this.vodRemarks,
      vodPubdate: vodPubdate ?? this.vodPubdate,
      vodTotal: vodTotal ?? this.vodTotal,
      vodSerial: vodSerial ?? this.vodSerial,
      vodTv: vodTv ?? this.vodTv,
      vodWeekday: vodWeekday ?? this.vodWeekday,
      vodArea: vodArea ?? this.vodArea,
      vodLang: vodLang ?? this.vodLang,
      vodYear: vodYear ?? this.vodYear,
      vodVersion: vodVersion ?? this.vodVersion,
      vodState: vodState ?? this.vodState,
      vodAuthor: vodAuthor ?? this.vodAuthor,
      vodJumpurl: vodJumpurl ?? this.vodJumpurl,
      vodTpl: vodTpl ?? this.vodTpl,
      vodTplPlay: vodTplPlay ?? this.vodTplPlay,
      vodTplDown: vodTplDown ?? this.vodTplDown,
      vodIsend: vodIsend ?? this.vodIsend,
      vodLock: vodLock ?? this.vodLock,
      vodLevel: vodLevel ?? this.vodLevel,
      vodCopyright: vodCopyright ?? this.vodCopyright,
      vodPoints: vodPoints ?? this.vodPoints,
      vodPointsPlay: vodPointsPlay ?? this.vodPointsPlay,
      vodPointsDown: vodPointsDown ?? this.vodPointsDown,
      vodHits: vodHits ?? this.vodHits,
      vodHitsDay: vodHitsDay ?? this.vodHitsDay,
      vodHitsWeek: vodHitsWeek ?? this.vodHitsWeek,
      vodHitsMonth: vodHitsMonth ?? this.vodHitsMonth,
      vodDuration: vodDuration ?? this.vodDuration,
      vodUp: vodUp ?? this.vodUp,
      vodDown: vodDown ?? this.vodDown,
      vodScore: vodScore ?? this.vodScore,
      vodScoreAll: vodScoreAll ?? this.vodScoreAll,
      vodScoreNum: vodScoreNum ?? this.vodScoreNum,
      vodTime: vodTime ?? this.vodTime,
      vodTimeAdd: vodTimeAdd ?? this.vodTimeAdd,
      vodTimeHits: vodTimeHits ?? this.vodTimeHits,
      vodTimeMake: vodTimeMake ?? this.vodTimeMake,
      vodTrysee: vodTrysee ?? this.vodTrysee,
      vodDoubanId: vodDoubanId ?? this.vodDoubanId,
      vodDoubanScore: vodDoubanScore ?? this.vodDoubanScore,
      vodReurl: vodReurl ?? this.vodReurl,
      vodRelVod: vodRelVod ?? this.vodRelVod,
      vodRelArt: vodRelArt ?? this.vodRelArt,
      vodPwd: vodPwd ?? this.vodPwd,
      vodPwdUrl: vodPwdUrl ?? this.vodPwdUrl,
      vodPwdPlay: vodPwdPlay ?? this.vodPwdPlay,
      vodPwdPlayUrl: vodPwdPlayUrl ?? this.vodPwdPlayUrl,
      vodPwdDown: vodPwdDown ?? this.vodPwdDown,
      vodPwdDownUrl: vodPwdDownUrl ?? this.vodPwdDownUrl,
      vodContent: vodContent ?? this.vodContent,
      vodPlayFrom: vodPlayFrom ?? this.vodPlayFrom,
      vodPlayServer: vodPlayServer ?? this.vodPlayServer,
      vodPlayNote: vodPlayNote ?? this.vodPlayNote,
      vodPlayUrl: vodPlayUrl ?? this.vodPlayUrl,
      vodDownFrom: vodDownFrom ?? this.vodDownFrom,
      vodDownServer: vodDownServer ?? this.vodDownServer,
      vodDownNote: vodDownNote ?? this.vodDownNote,
      vodDownUrl: vodDownUrl ?? this.vodDownUrl,
      vodPlot: vodPlot ?? this.vodPlot,
      vodPlotName: vodPlotName ?? this.vodPlotName,
      vodPlotDetail: vodPlotDetail ?? this.vodPlotDetail,
      vodPicScreenshot: vodPicScreenshot ?? this.vodPicScreenshot,
      typeName: typeName ?? this.typeName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItemJson &&
          runtimeType == other.runtimeType &&
          vodId == other.vodId &&
          typeId == other.typeId &&
          typeId1 == other.typeId1 &&
          groupId == other.groupId &&
          vodName == other.vodName &&
          vodSub == other.vodSub &&
          vodEn == other.vodEn &&
          vodStatus == other.vodStatus &&
          vodLetter == other.vodLetter &&
          vodColor == other.vodColor &&
          vodTag == other.vodTag &&
          vodClass == other.vodClass &&
          vodPic == other.vodPic &&
          vodPicThumb == other.vodPicThumb &&
          vodPicSlide == other.vodPicSlide &&
          vodActor == other.vodActor &&
          vodDirector == other.vodDirector &&
          vodWriter == other.vodWriter &&
          vodBehind == other.vodBehind &&
          vodBlurb == other.vodBlurb &&
          vodRemarks == other.vodRemarks &&
          vodPubdate == other.vodPubdate &&
          vodTotal == other.vodTotal &&
          vodSerial == other.vodSerial &&
          vodTv == other.vodTv &&
          vodWeekday == other.vodWeekday &&
          vodArea == other.vodArea &&
          vodLang == other.vodLang &&
          vodYear == other.vodYear &&
          vodVersion == other.vodVersion &&
          vodState == other.vodState &&
          vodAuthor == other.vodAuthor &&
          vodJumpurl == other.vodJumpurl &&
          vodTpl == other.vodTpl &&
          vodTplPlay == other.vodTplPlay &&
          vodTplDown == other.vodTplDown &&
          vodIsend == other.vodIsend &&
          vodLock == other.vodLock &&
          vodLevel == other.vodLevel &&
          vodCopyright == other.vodCopyright &&
          vodPoints == other.vodPoints &&
          vodPointsPlay == other.vodPointsPlay &&
          vodPointsDown == other.vodPointsDown &&
          vodHits == other.vodHits &&
          vodHitsDay == other.vodHitsDay &&
          vodHitsWeek == other.vodHitsWeek &&
          vodHitsMonth == other.vodHitsMonth &&
          vodDuration == other.vodDuration &&
          vodUp == other.vodUp &&
          vodDown == other.vodDown &&
          vodScore == other.vodScore &&
          vodScoreAll == other.vodScoreAll &&
          vodScoreNum == other.vodScoreNum &&
          vodTime == other.vodTime &&
          vodTimeAdd == other.vodTimeAdd &&
          vodTimeHits == other.vodTimeHits &&
          vodTimeMake == other.vodTimeMake &&
          vodTrysee == other.vodTrysee &&
          vodDoubanId == other.vodDoubanId &&
          vodDoubanScore == other.vodDoubanScore &&
          vodReurl == other.vodReurl &&
          vodRelVod == other.vodRelVod &&
          vodRelArt == other.vodRelArt &&
          vodPwd == other.vodPwd &&
          vodPwdUrl == other.vodPwdUrl &&
          vodPwdPlay == other.vodPwdPlay &&
          vodPwdPlayUrl == other.vodPwdPlayUrl &&
          vodPwdDown == other.vodPwdDown &&
          vodPwdDownUrl == other.vodPwdDownUrl &&
          vodContent == other.vodContent &&
          vodPlayFrom == other.vodPlayFrom &&
          vodPlayServer == other.vodPlayServer &&
          vodPlayNote == other.vodPlayNote &&
          vodPlayUrl == other.vodPlayUrl &&
          vodDownFrom == other.vodDownFrom &&
          vodDownServer == other.vodDownServer &&
          vodDownNote == other.vodDownNote &&
          vodDownUrl == other.vodDownUrl &&
          vodPlot == other.vodPlot &&
          vodPlotName == other.vodPlotName &&
          vodPlotDetail == other.vodPlotDetail &&
          vodPicScreenshot == other.vodPicScreenshot &&
          typeName == other.typeName;

  @override
  int get hashCode => Object.hashAll([
        vodId,
        typeId,
        typeId1,
        groupId,
        vodName,
        vodSub,
        vodEn,
        vodStatus,
        vodLetter,
        vodColor,
        vodTag,
        vodClass,
        vodPic,
        vodPicThumb,
        vodPicSlide,
        vodActor,
        vodDirector,
        vodWriter,
        vodBehind,
        vodBlurb,
        vodRemarks,
        vodPubdate,
        vodTotal,
        vodSerial,
        vodTv,
        vodWeekday,
        vodArea,
        vodLang,
        vodYear,
        vodVersion,
        vodState,
        vodAuthor,
        vodJumpurl,
        vodTpl,
        vodTplPlay,
        vodTplDown,
        vodIsend,
        vodLock,
        vodLevel,
        vodCopyright,
        vodPoints,
        vodPointsPlay,
        vodPointsDown,
        vodHits,
        vodHitsDay,
        vodHitsWeek,
        vodHitsMonth,
        vodDuration,
        vodUp,
        vodDown,
        vodScore,
        vodScoreAll,
        vodScoreNum,
        vodTime,
        vodTimeAdd,
        vodTimeHits,
        vodTimeMake,
        vodTrysee,
        vodDoubanId,
        vodDoubanScore,
        vodReurl,
        vodRelVod,
        vodRelArt,
        vodPwd,
        vodPwdUrl,
        vodPwdPlay,
        vodPwdPlayUrl,
        vodPwdDown,
        vodPwdDownUrl,
        vodContent,
        vodPlayFrom,
        vodPlayServer,
        vodPlayNote,
        vodPlayUrl,
        vodDownFrom,
        vodDownServer,
        vodDownNote,
        vodDownUrl,
        vodPlot,
        vodPlotName,
        vodPlotDetail,
        vodPicScreenshot,
        typeName,
      ]);
}

class EpginfoList {
  EpginfoList({
    required this.date,
    required this.channelName,
    required this.url,
    required this.epgData,
  });

  factory EpginfoList.fromJson(Map json) {
    final epgData = json['epg_data'];
    return EpginfoList(
      date: json['date'],
      channelName: json['channel_name'],
      url: json['url'],
      epgData: epgData.map<Epginfo>((e) {
        return Epginfo.fromJson(
          e as Map<dynamic, dynamic>,
        );
      }).toList(),
    );
  }

  final dynamic date;
  final dynamic channelName;
  final dynamic url;
  final List<Epginfo> epgData;

  Map<dynamic, dynamic> toJson() {
    return {
      'date': date,
      'channel_name': channelName,
      'url': url,
      'epg_data': epgData,
    };
  }

  EpginfoList copyWith({
    dynamic date,
    dynamic channelName,
    dynamic url,
    List<Epginfo>? epgData,
  }) {
    return EpginfoList(
      date: date ?? this.date,
      channelName: channelName ?? this.channelName,
      url: url ?? this.url,
      epgData: epgData ?? this.epgData,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpginfoList &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          channelName == other.channelName &&
          url == other.url &&
          const DeepCollectionEquality().equals(epgData, other.epgData);

  @override
  int get hashCode => Object.hashAll([
        date,
        channelName,
        url,
        const DeepCollectionEquality().hash(epgData),
      ]);
}

class Epginfo {
  Epginfo({
    required this.start,
    required this.desc,
    required this.end,
    required this.title,
  });

  factory Epginfo.fromJson(Map json) {
    return Epginfo(
      start: json['start'],
      desc: json['desc'],
      end: json['end'],
      title: json['title'],
    );
  }

  final dynamic start;
  final dynamic desc;
  final dynamic end;
  final dynamic title;

  Map<dynamic, dynamic> toJson() {
    return {
      'start': start,
      'desc': desc,
      'end': end,
      'title': title,
    };
  }

  Epginfo copyWith({
    dynamic start,
    dynamic desc,
    dynamic end,
    dynamic title,
  }) {
    return Epginfo(
      start: start ?? this.start,
      desc: desc ?? this.desc,
      end: end ?? this.end,
      title: title ?? this.title,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Epginfo &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          desc == other.desc &&
          end == other.end &&
          title == other.title;

  @override
  int get hashCode => Object.hashAll([
        start,
        desc,
        end,
        title,
      ]);
}

class LiveChannelItem {
  final dynamic name;
  final List<dynamic> urls;
  EpginfoList? epginfoList;
  int epginfoIndex;
  int index;

  LiveChannelItem(this.name, this.urls,
      {this.epginfoList, this.epginfoIndex = 0, this.index = 0});
}

class MessageEvent {
  final int type;
  final dynamic content;

  MessageEvent(this.type, this.content);
}

class MessageEventType {
  const MessageEventType._();

  static const int up = 1;
  static const int down = 2;
  static const int up2 = 3;
  static const int down2 = 4;
  static const int pause = 5;
  static const int play = 6;
  static const int search = 7;
  static const int close = 8;
  static const int changeItem = 9;
  static const int other = 0;
}

class LiveModelItem {
  final String title;
  final String url;

  LiveModelItem(this.title, this.url);
}

class LiveModel {
  final String key;
  final List<LiveModelItem> item = [];

  LiveModel(this.key);
}
