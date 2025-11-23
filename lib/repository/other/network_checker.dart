import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum NetworkStatus { notDetermined, on, off, wifi, bluetooth, vpn, other }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();
  late NetworkStatus lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    lastResult = NetworkStatus.notDetermined;
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isEmpty) return;

      // Pick the first result for backward-compatible behavior
      final result = results.first;

      late NetworkStatus newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.off;
          break;
        case ConnectivityResult.bluetooth:
          newState = NetworkStatus.bluetooth;
          break;
        case ConnectivityResult.ethernet:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.vpn:
          newState = NetworkStatus.vpn;
          break;
        case ConnectivityResult.other:
          newState = NetworkStatus.other;
          break;
      }

      if (newState != state) {
        state = newState;
      }
    });
  }
}
