import 'package:equatable/equatable.dart';

class AntreanResponse extends Equatable {
  const AntreanResponse({
    required this.result,
    required this.status,
    required this.message,
  });

  final List<AntreanModel> result;
  final String? status;
  final String? message;

  AntreanResponse copyWith({
    List<AntreanModel>? result,
    String? status,
    String? message,
  }) {
    return AntreanResponse(
      result: result ?? this.result,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  factory AntreanResponse.fromJson(Map<String, dynamic> json) {
    return AntreanResponse(
      result: json["result"] == null
          ? []
          : List<AntreanModel>.from(
              json["result"]!.map((x) => AntreanModel.fromJson(x))),
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

// class AntreanModelByPoli {}

class AntreanModel extends Equatable {
  const AntreanModel({
    required this.deptName,
    required this.drspName,
    required this.pegName,
    required this.pegPhoto,
    required this.ralanNoantrian,
    required this.pasienBelumDatang,
    required this.pasienDatangBelumDiperiksa,
    required this.pasienSudahDiperiksa,
    required this.pasienPulang,
    required this.tidakDatang,
    required this.antre,
  });

  final String? deptName;
  final String? drspName;
  final String? pegName;
  final String? pegPhoto;
  final String? ralanNoantrian;
  final String? pasienBelumDatang;
  final String? pasienDatangBelumDiperiksa;
  final String? pasienSudahDiperiksa;
  final String? pasienPulang;
  final String? tidakDatang;
  final List<Antre> antre;

  AntreanModel copyWith({
    String? deptName,
    String? drspName,
    String? pegName,
    String? pegPhoto,
    String? ralanNoantrian,
    String? pasienBelumDatang,
    String? pasienDatangBelumDiperiksa,
    String? pasienSudahDiperiksa,
    String? pasienPulang,
    String? tidakDatang,
    List<Antre>? antre,
  }) {
    return AntreanModel(
      deptName: deptName ?? this.deptName,
      drspName: drspName ?? this.drspName,
      pegName: pegName ?? this.pegName,
      pegPhoto: pegPhoto ?? this.pegPhoto,
      ralanNoantrian: ralanNoantrian ?? this.ralanNoantrian,
      pasienBelumDatang: pasienBelumDatang ?? this.pasienBelumDatang,
      pasienDatangBelumDiperiksa:
          pasienDatangBelumDiperiksa ?? this.pasienDatangBelumDiperiksa,
      pasienSudahDiperiksa: pasienSudahDiperiksa ?? this.pasienSudahDiperiksa,
      pasienPulang: pasienPulang ?? this.pasienPulang,
      tidakDatang: tidakDatang ?? this.tidakDatang,
      antre: antre ?? this.antre,
    );
  }

  factory AntreanModel.fromJson(Map<String, dynamic> json) {
    return AntreanModel(
      deptName: json["dept_name"],
      drspName: json["drsp_name"],
      pegName: json["peg_name"],
      pegPhoto: json["peg_photo"],
      ralanNoantrian: json["ralan_noantrian"].toString(),
      pasienBelumDatang: json["pasien_belum_datang"].toString(),
      pasienDatangBelumDiperiksa:
          json["pasien_datang_belum_diperiksa"].toString(),
      pasienSudahDiperiksa: json["pasien_sudah_diperiksa"].toString(),
      pasienPulang: json["pasien_pulang"].toString(),
      tidakDatang: json["tidak_datang"].toString(),
      antre: json["antre"] == null
          ? []
          : List<Antre>.from(json["antre"]!.map((x) => Antre.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
        deptName,
        drspName,
        pegName,
        pegPhoto,
        ralanNoantrian,
        pasienBelumDatang,
        pasienDatangBelumDiperiksa,
        pasienSudahDiperiksa,
        pasienPulang,
        tidakDatang,
        antre,
      ];
}

class Antre extends Equatable {
  const Antre({
    required this.noAntre,
    required this.status,
  });

  final String? noAntre;
  final String? status;

  Antre copyWith({
    String? noAntre,
    String? status,
  }) {
    return Antre(
      noAntre: noAntre ?? this.noAntre,
      status: status ?? this.status,
    );
  }

  factory Antre.fromJson(Map<String, dynamic> json) {
    return Antre(
      noAntre: json["no_antre"],
      status: json["status"],
    );
  }

  @override
  List<Object?> get props => [
        noAntre,
        status,
      ];
}
