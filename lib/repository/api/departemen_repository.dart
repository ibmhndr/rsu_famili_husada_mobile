import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rsufamilyhusadacare_mobile/model/departemen_response.dart';
import 'package:rsufamilyhusadacare_mobile/repository/abstract/api_post.dart';
import 'package:rsufamilyhusadacare_mobile/settings/network_settings.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/splash_screen/splash_screen_state.dart';

class DepartemenRepository extends ApiPost {
  //Singleton
  DepartemenRepository._privateConstructor();
  static final DepartemenRepository instance =
      DepartemenRepository._privateConstructor();
  factory DepartemenRepository() {
    return instance;
  }

  final String _errorLabel = 'Terjadi kegagalan memperoleh data departemen';
  final String uri =
      '/index.php?pagetype=service&page=Web-Service-Antrean-Pasien&action=getDepartemen';

  @override
  Future<DepartemenResponse> postData(Map<String, dynamic> data,
      {CancelToken? token}) async {
    try {
      //Add Tiket
      data['tiket'] = SplashScreenState.tiket;

      if (kDebugMode) {
        print('======POST======');
        print("Network Post Device : ${NetworkSettings.hosts}$uri");
        print("Data : $data");
      }
      //Change to form data
      FormData formData = FormData.fromMap(data);

      final response = await NetworkSettings.dio.post(
        uri,
        data: formData,
        cancelToken: token,
      );

      //Function untuk menjalankan fungsi jika diawait
      return compute(parseResult, response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
        showToast(_errorLabel);
      }

      throw Exception(e.message);
    }
  }

  @override
  DepartemenResponse parseResult(responseBody) {
    if (kDebugMode) {
      print("Response Body : $responseBody");
    }

    return (responseBody != null)
        ? (responseBody['result'] != '403')
            //@If Result denied
            ? DepartemenResponse.fromJson(responseBody)
            : DepartemenResponse(
                status: 'error',
                message: _errorLabel,
                result: const [],
              )
        : DepartemenResponse(
            status: 'error',
            message: _errorLabel,
            result: const [],
          );
  }
}
