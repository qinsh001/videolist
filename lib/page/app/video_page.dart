import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:videolist/local/constant.dart';
import 'package:videolist/model/simple_models.dart';
import 'package:videolist/utils/app_utils.dart';

import 'package:videolist/widget/cache_image.dart';
import '../../router/router.dart';

class VideoKitPage extends StatefulWidget {
  final List<M3UEntry> urls;

  const VideoKitPage({super.key, required this.urls});

  @override
  State<VideoKitPage> createState() => _VideoKitPageState();
}

class _VideoKitPageState extends State<VideoKitPage> {
  late final Player player = Player(
    configuration: PlayerConfiguration(
      // Supply your options:
      title: 'My awesome package:media_kit application',
      ready: () {
        print('The initialization is complete.');
      },
    ),
  );

  late final item = widget.urls.first;
  late final playable = Playlist(
    [
      Media(item.playUrl),
    ],
    index: 0,
  );
  late final controller = VideoController(player);
  late final GlobalKey<VideoState> key = GlobalKey<VideoState>();

  @override
  void initState() {
    super.initState();
    player.open(playable);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      key.currentState?.enterFullscreen();
    });
  }

  List<Widget> topBar(BuildContext context) {
    return [
      MaterialCustomButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (key.currentState?.isFullscreen() ?? false) {
            key.currentState?.exitFullscreen();
          }
          goRouter.pop();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (item.logo.isNotEmpty)
              SizedBox(
                height: 40,
                width: 60,
                child: CacheImage(
                  path: item.logo,
                ),
              ),
            Text(item.title),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width * 9.0 / 16.0,
            // Use [Video] widget to display video output.
            child: MaterialVideoControlsTheme(
                normal: MaterialVideoControlsThemeData(
                  topButtonBar: topBar(context),
                ),
                fullscreen: MaterialVideoControlsThemeData(
                  topButtonBar: topBar(context),
                ),
                child: // Wrap [Video] widget with [MaterialDesktopVideoControlsTheme].
                    MaterialVideoControlsTheme(
                        normal: MaterialVideoControlsThemeData(
                          topButtonBar: topBar(context),
                        ),
                        fullscreen: MaterialVideoControlsThemeData(
                          topButtonBar: topBar(context),
                        ),
                        child: Video(
                          key: key,
                          controller: controller,
                          onEnterFullscreen: () async {
                            await defaultEnterNativeFullscreen();
                          },
                          onExitFullscreen: () async {
                            await defaultExitNativeFullscreen();
                          },
                        ))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() async {
    player.dispose();
    super.dispose();
  }
}

class VideoUrlListPage extends StatefulWidget {
  const VideoUrlListPage({super.key});

  @override
  State<VideoUrlListPage> createState() => _VideoUrlListPageState();
}

class _VideoUrlListPageState extends State<VideoUrlListPage> {
  final items = [
    (title: "APTV", url: "${ConstantS.url9}APTV.m3u"),
  ];
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电视"),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 100,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      selectIndex = index;
                    });
                  },
                  title: Text(
                    items[index].title,
                    style: TextStyle(
                      color: selectIndex == index ? Colors.blue : Colors.black,
                    ),
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: AppUtils.parseM3UFromUrl(items[selectIndex].url),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      final data = snap.data as List<M3UEntry>;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return ListTile(
                            onTap: () {
                              VideoPlayerRoute([item]).push(context);
                            },
                            title: Text(item.title),
                          );
                        },
                        itemCount: data.length,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
