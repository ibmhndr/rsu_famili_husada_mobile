import 'package:equatable/equatable.dart';

class PostResponseModel extends Equatable {
  String? status;
  String? message;

  PostResponseModel({this.status, this.message});

  PostResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
