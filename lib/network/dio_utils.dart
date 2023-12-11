import 'package:dio/dio.dart';

typedef ResponseBodyT<T> = T Function(Map<String, dynamic>?);

class DioUtils {
  static Dio dio = Dio()
    ..options = BaseOptions(baseUrl: "https://node.video.qq.com/x/api/");

  static Future<T> getUrl<T>(
      {required ResponseBodyT<T> responseBodyT,
      required String path,
      String? baseUrl,
      Map<String, dynamic>? map,
      dynamic cancelRequest}) async {
    final queryParameters = <String, dynamic>{};
    if (map != null) queryParameters.addAll(map);
    final result =
        await dio.fetch<Map<String, dynamic>>(_setStreamType<T>(Options(
      method: 'GET',
    )
            .compose(
              dio.options,
              path,
              queryParameters: queryParameters,
              cancelToken: cancelRequest,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              dio.options.baseUrl,
              baseUrl,
            ))));
    final value = responseBodyT(result.data!);
    return value;
  }



  static Future<T> postUrl<T>({
    required ResponseBodyT<T> responseBodyT,
    required String path,
    String? baseUrl,
    Map<String, dynamic>? map,
    dynamic cancelRequest,
  }) async {
    final data = <String, dynamic>{};
    if (map != null) data.addAll(map);
    final result = await dio.fetch<
        Map<String, dynamic>>(_setStreamType<T>(Options(
      method: 'POST',
      contentType: 'application/x-www-form-urlencoded',
    )
        .compose(
          dio.options,
          path,
          data: data,
          cancelToken: cancelRequest,
        )
        .copyWith(baseUrl: _combineBaseUrls(dio.options.baseUrl, baseUrl))));
    final value = responseBodyT(result.data!);
    return value;
  }


  static RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  static String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }
    if (baseUrl.startsWith("http")) {
      return baseUrl;
    }
    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
