import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum ConnectionStatus { internetAvailable, internetNotAvailable }

class Connection {
  Connection._privateConstructor();
  static final Connection instance = Connection._privateConstructor();
  factory Connection() => instance;

  Future<ConnectionStatus> checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (kDebugMode) print('No network interface (WiFi/Mobile)');
      return ConnectionStatus.internetNotAvailable;
    }

    try {
      final response = await http
          .get(Uri.parse('https://clients3.google.com/generate_204'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 204) {
        return ConnectionStatus.internetAvailable;
      } else {
        if (kDebugMode) print('Connected but response was not 204');
        return ConnectionStatus.internetNotAvailable;
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket exception: $e');
      }
      return ConnectionStatus.internetNotAvailable;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      return ConnectionStatus.internetNotAvailable;
    }
  }
}
