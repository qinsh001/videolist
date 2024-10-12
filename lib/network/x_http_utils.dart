import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:videolist/utils/app_utils.dart';

import '../model/simple_models.dart';

class XHttpUtils {
  static const String _baseUrl = ''; // 替换为你的基础 URL
  static String? _authToken;

  // 设置认证token
  static void setAuthToken(String token) {
    _authToken = token;
  }

  // GET 请求
  static Future<T?> get<T>(String path, {Map<String, String>? headers}) async {
    final fullUrl = '$_baseUrl$path';
    final updatedHeaders = _addAuthHeader(_addUtf8Header(headers));

    _logRequest('GET', fullUrl, headers: updatedHeaders);

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: updatedHeaders,
    );

    _logResponse(response);

    return _handleResponse<T>(response);
  }

  // POST 请求
  static Future<T?> post<T>(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final fullUrl = '$_baseUrl$path';
    final updatedHeaders = _addAuthHeader(_addUtf8Header(headers));
    final encodedBody = _encodeBody(body);

    _logRequest('POST', fullUrl, headers: updatedHeaders, body: encodedBody);

    final response = await http.post(
      Uri.parse(fullUrl),
      headers: updatedHeaders,
      body: encodedBody,
      encoding: utf8,
    );

    _logResponse(response);

    return _handleResponse<T>(response);
  }

  // 添加 UTF-8 header
  static Map<String, String> _addUtf8Header(Map<String, String>? headers) {
    final updatedHeaders = headers ?? {};
    if (!updatedHeaders.containsKey('Content-Type')) {
      updatedHeaders['Content-Type'] = 'application/json; charset=UTF-8';
    }
    return updatedHeaders;
  }

  // 添加认证 header
  static Map<String, String> _addAuthHeader(Map<String, String> headers) {
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  // 编码请求体
  static String? _encodeBody(Object? body) {
    if (body == null) return null;
    if (body is String) return body;
    return json.encode(body);
  }

  // 处理响应
  static T? _handleResponse<T>(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (T is Uint8List) {
        return response.bodyBytes as T;
      }
      return _parseResponse<T>(utf8.decode(response.bodyBytes));
    } else {
      throw HttpException(response.statusCode, utf8.decode(response.bodyBytes));
    }
  }

  // 解析响应
  static T? _parseResponse<T>(String responseBody) {
    final jsonData2 = AppUtils.getDataByJson(responseBody);
    if (!jsonData2.isJson) {
      //如果不是json 默认返回string类型
      return jsonData2.data as T;
    }
    final jsonData = jsonData2.data;
    if (T == String) {
      return responseBody as T;
    } else if (T == Map<String, dynamic>) {
      return jsonData as T;
    } else if (T == List<dynamic>) {
      return jsonData as T;
    } else if (jsonData == null) {
      return null;
    } else {
      // 如果是自定义对象,你需要实现一个fromJson方法
      // 例如: return YourObject.fromJson(jsonData);
      if (T == EpginfoList) {
        return EpginfoList.fromJson(jsonData) as T;
      } else if (T == TvboxModel) {
        return TvboxModel.fromJson(jsonData) as T;
      } else if (T == ListInfoItem2) {
        return ListInfoItem2.fromJson(jsonData) as T;
      }
      throw Exception('Unsupported type: $T');
    }
  }

  // 记录请求日志
  static void _logRequest(String method, String url,
      {Map<String, String>? headers, String? body}) {
    print('---> $method $url');
    headers?.forEach((key, value) => print('$key: $value'));
    if (body != null) {
      print(body);
    }
    print('---> END $method');
  }

  // 记录响应日志
  static void _logResponse(http.Response response) {
    print('<--- ${response.statusCode} ${response.request?.url}');
    response.headers.forEach((key, value) => print('$key: $value'));
    print(response.body);
    print('<--- END HTTP');
  }
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() => 'HttpException: $statusCode - $message';
}
