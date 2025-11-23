import 'package:flutter/material.dart';

class SplashScreenState {
  bool isLogin = false;

  //Responsive Apps
  static String status = 'normal';
  static MediaQueryData? deviceSetting;
  static String? tiket = '';
  // static bool isPhyscalDevice = false;
  // static bool isRoot = true;
  // static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

//<editor-fold desc="Data Methods">
  SplashScreenState({
    required this.isLogin,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SplashScreenState &&
          runtimeType == other.runtimeType &&
          isLogin == other.isLogin);

  @override
  int get hashCode => isLogin.hashCode;

  @override
  String toString() {
    return 'SplashScreenState{isLogin: $isLogin,}';
  }

  SplashScreenState copyWith({
    bool? isLogin,
  }) {
    return SplashScreenState(
      isLogin: isLogin ?? this.isLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLogin': isLogin,
    };
  }

  factory SplashScreenState.fromMap(Map<String, dynamic> map) {
    return SplashScreenState(
      isLogin: map['isLogin'] as bool,
    );
  }

//</editor-fold>
}
