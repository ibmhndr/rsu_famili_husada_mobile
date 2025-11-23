import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:rsufamilyhusadacare_mobile/repository/other/connection_checker.dart';

class NetworkSettings {
  static const String hosts = 'https://rsufamilyhusada.com';
  static var dio = Dio(
    BaseOptions(
        baseUrl: NetworkSettings.hosts,
        headers: {
          "Accept": "application/json",
        },
        validateStatus: (status) {
          return (status ?? 500) <= 500;
        }
        // connectTimeout: 10000,
        // receiveTimeout: 3000,
        ),
  );
  // final Connectivity connectivity = Connectivity();

  static void initNetworkSetting() {
    if (kDebugMode) {
      print("Init Network Settings");
    }

    //@Set Default Http Client Adapter (FIX ISSUE CERTIFICATE ERROR ON ANDROID BELOW 6)
    NetworkSettings.dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        // Config the client.
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        if (kDebugMode) {
          print("======Bad Certificate Set Successfully=======");
        }
        // You can also create a new HttpClient for Dio instead of returning,
        // but a client must being returned here.
        return client;
      },
    );

    //@Add Retry Interceptor
    NetworkSettings.dio.interceptors.add(RetryInterceptor(
      dio: NetworkSettings.dio,
      logPrint: print, // specify log function
      retries: 5, // retry count
      retryDelays: const [
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 3), // wait 3 sec before second retry
        Duration(seconds: 6), // wait 6 sec before third retry
        Duration(seconds: 9), // wait 9 sec before third retry
        Duration(seconds: 12), // wait 12 sec before third retry
      ],
    ));

    //@Add Pretty Logger
    NetworkSettings.dio.interceptors.add(PrettyDioLogger());

    //@Add Interceptor for every request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.

          //@Try Checking Connection
          try {
            final connectionStatus =
                await Connection.instance.checkConnection();
            if (connectionStatus == ConnectionStatus.internetAvailable) {
              //@Simulate error
              // handler.reject(DioException.connectionError(
              //     requestOptions: options,
              //     reason: "Koneksi internet tidak tersedia")
              // );

              //@Next handler request
              return handler.next(options);
            } else {
              return handler.reject(
                DioException.connectionError(
                  requestOptions: options,
                  reason: "Koneksi internet tidak tersedia",
                ),
              );
            }
          } on DioException catch (e) {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              // String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              // e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              // Repeat the request with the updated header
              return handler.resolve(await dio.fetch(e.requestOptions));
            }

            return handler.reject(e);
          }
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.next(e);
        },
      ),
    );
  }
}

//making new request in dio by removing first request
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({
    this.milliseconds = 500,
  });

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
