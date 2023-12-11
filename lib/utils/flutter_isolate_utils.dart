import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:videolist/utils/local_ip_address.dart';
import 'package:videolist/utils/server_utils.dart';

import '../model/simple_models.dart';

class FlutterIsolateUtils {
  static Future<Isolate> startServerIsolate2(Function(SendPort) result,
      {Function(dynamic)? result2}) async {
    final ip = await LocalIPAddress.getIP();
    print("startServer2=ip=$ip");
    final ReceivePort mainReceivePort = ReceivePort();
    Isolate isolate =
        await Isolate.spawn(startServer2, [mainReceivePort.sendPort, ip]);
    mainReceivePort.listen((data) {
      if (data is SendPort) {
        result(data);
      } else {
        result2?.call(data);
      }
    });
    return isolate;
  }

  static Future<(Isolate, ReceivePort)> startServerIsolate() async {
    final ip = await LocalIPAddress.getIP();
    final ReceivePort mainReceivePort = ReceivePort();
    Isolate isolate =
        await Isolate.spawn(startServer2, [mainReceivePort.sendPort, ip]);
    return (isolate, mainReceivePort);
  }

  static void startServer2(List<dynamic> args) async {
    final mainReceivePort = args[0];
    final ip = args[1];
    final server = await HttpServer.bind(ip, 9987);
    final ReceivePort isolateReceivePort = ReceivePort();
    mainReceivePort.send(isolateReceivePort.sendPort);
    isolateReceivePort.listen((message) {
      print('isolateReceivePort=data=$message');
      if (message is MessageEvent && message.type == MessageEventType.close) {
        server.close();
      }
    });
    // 监听请求
    await for (HttpRequest request in server) {
      ServerUtils.handleRequest2(request, mainReceivePort);
      await request.response.close();
    }
  }

  static void cancelReceivePort(StreamSubscription? subscription) {
    subscription?.cancel();
  }
}
