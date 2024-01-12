import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videolist/model/simple_models.dart';
import 'package:videolist/utils/app_utils.dart';
import 'package:videolist/utils/log_extensions.dart';

class VideoDetailPage extends StatefulWidget {
  final ListItemJson item;

  const VideoDetailPage({super.key, required this.item});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  late final videoUrls = AppUtils.getVideoUrls(widget.item.vodPlayUrl);
  late ValueNotifier<String> videoUrl = ValueNotifier(videoUrls.first.url);

  ValueNotifier<int> progress = ValueNotifier(-1);

  Future<void> initializePlayer() async {
    progress.value = 0;
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl.value));
    await _videoPlayerController1.initialize();
    _createChewieController();
    progress.value = 1;
    videoUrl.value.log();
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoPlayerController1.value.aspectRatio,
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  Future<void> toggleVideo(int index) async {
    await _videoPlayerController1.dispose();
    videoUrl.value = videoUrls[index].url;
    "videoUrl.value=${videoUrl.value}".log();
    await initializePlayer();
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              builder: (context, snap, child) {
                if (snap == 1) {
                  return AspectRatio(
                    aspectRatio: _videoPlayerController1.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              valueListenable: progress,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(""),
                          ),
                        ),
                        Positioned.fill(
                            child: ValueListenableBuilder(
                          builder: (context, snap, child) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final item = videoUrls[index];
                                return InkWell(
                                  onTap: () {
                                    toggleVideo(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                          color: item.url == videoUrl.value
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                  ),
                                );
                              },
                              itemCount: videoUrls.length,
                            );
                          },
                          valueListenable: videoUrl,
                        ))
                      ],
                    ),
                    Text(widget.item.vodName),
                    Text(widget.item.typeName),
                    Text(widget.item.vodActor),
                    Text(widget.item.vodArea),
                    Text(widget.item.vodContent),
                    Text(widget.item.vodDirector),
                    Text("${widget.item.vodId}"),
                    Text(widget.item.vodLang),
                    Text(widget.item.vodRemarks),
                    Text(widget.item.vodTime),
                    Text(widget.item.vodYear),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
