import 'package:equatable/equatable.dart';

class DepartemenResponse extends Equatable {
  const DepartemenResponse({
    required this.result,
    required this.status,
    required this.message,
  });

  final List<DepartemenModel> result;
  final String? status;
  final String? message;

  DepartemenResponse copyWith({
    List<DepartemenModel>? result,
    String? status,
    String? message,
  }) {
    return DepartemenResponse(
      result: result ?? this.result,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory DepartemenResponse.fromJson(Map<String, dynamic> json) {
    return DepartemenResponse(
      result: json["result"] == null
          ? []
          : List<DepartemenModel>.from(
              json["result"]!.map((x) => DepartemenModel.fromJson(x))),
      status: json["status"],
      message: json["message"],
    );
  }

  @override
  List<Object?> get props => [
        result,
        status,
        message,
      ];
}

class DepartemenModel extends Equatable {
  const DepartemenModel({
    required this.deptId,
    required this.deptName,
  });

  final String? deptId;
  final String? deptName;

  DepartemenModel copyWith({
    String? deptId,
    String? deptName,
  }) {
    return DepartemenModel(
      deptId: deptId ?? this.deptId,
      deptName: deptName ?? this.deptName,
    );
  }

  factory DepartemenModel.fromJson(Map<String, dynamic> json) {
    return DepartemenModel(
      deptId: json["dept_id"],
      deptName: json["dept_name"],
    );
  }

  @override
  List<Object?> get props => [
        deptId,
        deptName,
      ];

  String getDepartemenName() => deptName ?? '';
}
