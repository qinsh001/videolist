import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:videolist/local/constant.dart';
import 'package:videolist/model/simple_models.dart';
import 'package:videolist/network/ApiUtils.dart';
import 'package:videolist/utils/app_utils.dart';
import 'package:videolist/utils/sp_utils.dart';
import 'package:videolist/widget/round_widget.dart';

import '../../router/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TvBox"),
        bottom: PreferredSize(preferredSize: Size.fromHeight(50), child: InkWell(
          onTap: () {
            const SearchRoute().push(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 30),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.3)),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: const Text(
              "搜索",
              style: TextStyle(fontSize: 14),
            ),
          ),
        )),
        actions: [
          TextButton(onPressed: (){
            // const VideoUrlListRoute().push(context);
            const Study324Route().push(context);
          }, child: Text("福利"))
        ],
      ),
      body: FutureBuilder(
        builder: (context, value) {
          if (value.hasData && value.connectionState == ConnectionState.done) {
            final items = value.data?.data.mapResult ?? [];
            return VideoPage(mapResult: items);
          }
          return const Center(child: CircularProgressIndicator());
        },
        future: ApiUtils.getHotData(),
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final List<MapResultItem> mapResult;

  const VideoPage({super.key, required this.mapResult});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController =
      TabController(length: widget.mapResult.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          padding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: tabController,
          tabs: widget.mapResult
              .mapIndexed((index, e) => Tab(
                  child: Text(AppUtils.getDefaultStr("${e.channelTitle}".trim(),
                      defaultStr: "其他$index"))))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: widget.mapResult
            .map((e) => VideoItemPage(
                  items: e,
                ))
            .toList(),
      ),
    );
  }
}

class VideoItemPage extends StatefulWidget {
  final MapResultItem items;

  const VideoItemPage({super.key, required this.items});

  @override
  State<VideoItemPage> createState() => _VideoItemPageState();
}

///
class _VideoItemPageState extends State<VideoItemPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: widget.items.listInfo.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.items.listInfo[index];
        return ListTile(
          onTap: () {
            SearchResultRoute(item.title).push(context);
          },
          title: Text(item.title),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _history.addAll(SpUtil.getStringList(ConstantS.spKeyHistory) ?? []);
  }

  @override
  void dispose() {
    SpUtil.putStringList(ConstantS.spKeyHistory, _history);
    super.dispose();
  }

  void _onSearch() {
    final keyword = _controller.text.trim();
    if (keyword.isEmpty) {
      return;
    }
    if (!_history.contains(keyword)) {
      setState(() {
        _history.add(keyword);
      });
    }
    SearchResultRoute(keyword).push(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(),
                hintText: "输入关键字",
              ),
            )),
            TextButton(
                onPressed: () {
                  _onSearch();
                },
                child: const Text("搜索"))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("历史记录"),
            Expanded(
                child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _history[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    SearchResultRoute(item).push(context);
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

///
class SearchResultPage extends StatefulWidget {
  final String title;

  const SearchResultPage({super.key, required this.title});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  StreamSubscription? streamSubscription;

  final videos = <ListItemJson>[];

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ApiUtils.getTvBoxData().then((result) {
      List<Future> futures = [];
      final list = result?.sites
          .where((element) =>
              AppUtils.isUrl("${element.ext}") ||
              AppUtils.isUrl("${element.api}"))
          .map((e) => AppUtils.getApiUrl(e.api, e.ext))
          .toList();
      list?.forEach((element) {
        futures.add(ApiUtils.getTvBoxData3(element, widget.title));
      });
      streamSubscription = Stream.fromFutures(futures).listen((event) {
        if (event != null) {
          setState(() {
            videos.addAll(VideoJson.fromJson(event).list.where((element) => AppUtils.isOkPlayUrl(element.vodPlayUrl)));
          });
        }
      })
        ..onDone(() {
          print("videos=${videos.length}");
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: videos.isEmpty?const Center(child: CircularProgressIndicator()):GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) {
          final item = videos[index];
          return GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black.withOpacity(0.3),
              title: Text(
                item.vodName,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            child: InkWell(
              onTap: () {
                VideoDetailRoute(item).push(context);
              },
              child: RoundImage(
                path: item.vodPic,
              ),
            ),
          );
        },
      ),
    );
  }
}
