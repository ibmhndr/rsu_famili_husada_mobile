import 'package:rsufamilyhusadacare_mobile/model/antrean_response.dart';
import 'package:rsufamilyhusadacare_mobile/model/departemen_response.dart';

class HomePageState {
  List<AntreanModel> listAntrean;
  Map<String, dynamic> antreanArgs;
  DepartemenModel departemen;
  bool isUpdate;
  bool isEnd;
  int pageNow;

//<editor-fold desc="Data Methods">
  HomePageState({
    required this.listAntrean,
    required this.antreanArgs,
    required this.departemen,
    required this.isUpdate,
    required this.isEnd,
    required this.pageNow,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HomePageState &&
          runtimeType == other.runtimeType &&
          listAntrean == other.listAntrean &&
          antreanArgs == other.antreanArgs &&
          departemen == other.departemen &&
          isUpdate == other.isUpdate &&
          isEnd == other.isEnd &&
          pageNow == other.pageNow);

  @override
  int get hashCode =>
      listAntrean.hashCode ^
      antreanArgs.hashCode ^
      departemen.hashCode ^
      isUpdate.hashCode ^
      isEnd.hashCode ^
      pageNow.hashCode;

  @override
  String toString() {
    return 'HomePageState{ listAntrean: $listAntrean, antreanArgs: $antreanArgs, departemen: $departemen, isUpdate: $isUpdate, isEnd: $isEnd, pageNow: $pageNow,}';
  }

  HomePageState copyWith({
    List<AntreanModel>? listAntrean,
    Map<String, dynamic>? antreanArgs,
    DepartemenModel? departemen,
    bool? isUpdate,
    bool? isEnd,
    int? pageNow,
  }) {
    return HomePageState(
      listAntrean: listAntrean ?? this.listAntrean,
      antreanArgs: antreanArgs ?? this.antreanArgs,
      departemen: departemen ?? this.departemen,
      isUpdate: isUpdate ?? this.isUpdate,
      isEnd: isEnd ?? this.isEnd,
      pageNow: pageNow ?? this.pageNow,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listAntrean': listAntrean,
      'antreanArgs': antreanArgs,
      'departemen': departemen,
      'isUpdate': isUpdate,
      'isEnd': isEnd,
      'pageNow': pageNow,
    };
  }

  factory HomePageState.fromMap(Map<String, dynamic> map) {
    return HomePageState(
      listAntrean: map['listAntrean'] as List<AntreanModel>,
      antreanArgs: map['antreanArgs'] as Map<String, dynamic>,
      departemen: map['departemen'] as DepartemenModel,
      isUpdate: map['isUpdate'] as bool,
      isEnd: map['isEnd'] as bool,
      pageNow: map['pageNow'] as int,
    );
  }

//</editor-fold>
}
