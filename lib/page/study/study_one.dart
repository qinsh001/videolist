import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:videolist/utils/log_extensions.dart';

class StudyOne extends StatefulWidget {
  const StudyOne({super.key});

  @override
  State<StudyOne> createState() => _StudyOneState();
}


class _StudyOneState extends State<StudyOne> {
  final controller = OverlayPortalController();
  double top = 100;

  _saveNetworkImage() async {
    var response = await Dio().get(
        "https://qr.stripe.com/test_YWNjdF8xTmp5dnhDVDBTbFN5YlRzLF9QQW1McXhpOFdGR2JPQmliNjZYNzhLRGxKczliMnB40100quLTgczp.png?download=true&border=2",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60);
    print(result);
  }

  late AppLifecycleListener lifecycleListener;

  @override
  void initState() {
    super.initState();
    lifecycleListener = AppLifecycleListener();
  }


  @override
  void dispose() {
    lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              if (controller.isShowing) {
                top = -300;
              } else {
                top = 100;
              }
              "top=$top".log();
              controller.toggle();
              // controller.show();
            },
            child: OverlayPortal(
              controller: controller,
              overlayChildBuilder: (BuildContext context) {
                return Positioned(
                  top: top,
                  height: MediaQuery.sizeOf(context).height - 100,
                  width: MediaQuery.sizeOf(context).width,
                  child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: Colors.white,
                            child: const Text("Hello World"),
                          ),
                        ],
                      )),
                );
              },
              child: Container(
                color: Colors.blue,
                child: const Text("Click me"),
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                // final path = (await getTemporaryDirectory()).path;
                // "path=$path".log();
                // DioUtils.downloadFile(
                //     "https://qr.stripe.com/test_YWNjdF8xTmp5dnhDVDBTbFN5YlRzLF9QQW1McXhpOFdGR2JPQmliNjZYNzhLRGxKczliMnB40100quLTgczp.png?download=true&border=2",
                //     "$path/a.png",onReceiveProgress: (int count, int total){
                //       "count=>$count total=>$total path2=$path".log();
                // });

                // Directory? appDirectory = await getExternalStorageDirectory();
                // if (appDirectory != null) {
                //   String albumPath = '${appDirectory.path}/DCIM/Camera';
                //   // 在这里可以使用相册路径进行进一步的操作
                //   "albumPath=$albumPath".log();
                // } else {
                //   // 无法获取相册路径
                // }
                _saveNetworkImage();
              },
              child: const Text("download"))
        ],
      ),
    );
  }
}
