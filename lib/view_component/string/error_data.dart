import 'package:rsufamilyhusadacare_mobile/model/post_response_model.dart';

class PostResponseErrorData {
  static networkError() {
    return PostResponseModel(
        message:
            "Terjadi kegagalan mengakses internet, pastikan internet anda sudah aktif",
        status: "error");
  }
}
