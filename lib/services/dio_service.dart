import 'dart:async';
import 'dart:io';
// Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';
// import 'package:firebase_performance/firebase_performance.dart';
import 'package:retry/retry.dart';
import 'package:sales_app/services/shared_preferences_service.dart';

// Project imports:

class DioConfig {
  // Static Dio created to directly access Dio client
  static Dio getDio({
    dynamic data,
    bool hasHeader = true,
    bool hasBody = true,
    bool hasInitToken = false,
    bool purchaseToken = false,
    bool enableUserToken = true,
  }) {
    var dio = Dio();
    Map<String, String> requestHeaders;

    final token = SharedPreferencesService.getAuthToken();

    // Passing Headers
    requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json;charset=UTF-8',
      if (hasInitToken) 'Authorization': token ?? '',
      'User-Agent': Platform.isAndroid ? 'Android' : 'iOS',
    };

    BaseOptions options;
    // Adding Additional Options
    options = BaseOptions(
      receiveTimeout: const Duration(minutes: 5),
      connectTimeout: const Duration(minutes: 5),
      headers: requestHeaders,
    );

    dio = Dio(options);

    // dio.interceptors.addAll([
    //   DioRequestInterceptor(hasBody, data),
    //   DioFirebasePerformanceInterceptor(),
    // ]);

    return dio;
  }

  Future<Response> dioServe({
    dynamic data,
    bool hasHeader = true,
    bool hasBody = true,
    bool hasInitToken = false,
    bool purchaseToken = false,
    bool enableUserToken = true,
    String? url,
    HttpMethod httpMethod = HttpMethod.Get,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response;
    const timeoutDuration = Duration(seconds: 120);
    final dio = getDio(
      data: data,
      hasHeader: hasHeader,
      hasBody: hasBody,
      hasInitToken: hasInitToken,
      purchaseToken: purchaseToken,
      enableUserToken: enableUserToken,
    );
    try {
      response = await retry(
        () async {
          final Response inResponse;
          switch (httpMethod) {
            case HttpMethod.Get:
              inResponse = await dio
                  .get(url!, queryParameters: queryParameters)
                  .timeout(timeoutDuration);
              break;
            case HttpMethod.Post:
              inResponse = await dio
                  .post(url!, queryParameters: queryParameters)
                  .timeout(timeoutDuration);
              break;
            case HttpMethod.Put:
              inResponse = await dio
                  .put(url!, queryParameters: queryParameters)
                  .timeout(timeoutDuration);
              break;
            case HttpMethod.Delete:
              inResponse = await dio
                  .delete(url!, queryParameters: queryParameters)
                  .timeout(timeoutDuration);
              break;
            case HttpMethod.Patch:
              inResponse = await dio
                  .patch(url!, queryParameters: queryParameters)
                  .timeout(timeoutDuration);
              break;
            default:
              inResponse = await dio
                  .get(url!, queryParameters: queryParameters)
                  .timeout(timeoutDuration);
              break;
          }

          return inResponse;
        },
        // Retry on SocketException or TimeoutException
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
      return response;
    } finally {
      dio.close();
    }
  }
}
