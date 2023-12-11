import 'dart:io';
import 'dart:isolate';

import 'package:videolist/utils/log_extensions.dart';
import 'package:videolist/model/simple_models.dart';

class ServerUtils {
  static void handleRequest2(HttpRequest request, SendPort sendPort) {
    // Access request properties
    var parameters = request.uri.queryParameters;
    if (request.method == "GET") {
      request.uri.log();
      final uri = request.uri.toString();
      if (uri.contains("action") &&
          parameters["type"] != null) {
        final messageEventType = switch (parameters["type"]) {
          "up" => MessageEventType.up,
          "down" => MessageEventType.down,
          "up2" => MessageEventType.up2,
          "down2" => MessageEventType.down2,
          "pause" => MessageEventType.pause,
          "play" => MessageEventType.play,
          "close" => MessageEventType.close,
          "changeItem" => MessageEventType.changeItem,
          _ => MessageEventType.other,
        };
        sendPort.send(MessageEvent(messageEventType, "${parameters["content"]}"));
      } else if (uri.contains("search") &&
          parameters["content"] != null) {
        sendPort.send(
            MessageEvent(MessageEventType.search, "${parameters["content"]}"));
      }
    }
    // Send a response
    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.text
      ..write('Hello, World!=${DateTime.now()}}');
  }
}
