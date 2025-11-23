import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rsufamilyhusadacare_mobile/model/antrean_response.dart';
import 'package:rsufamilyhusadacare_mobile/model/departemen_response.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/data/default/default_state.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/home_page/home_page_state.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/reference.dart';

class HomePageEvent extends StateNotifier<HomePageState> {
  HomePageEvent()
      : super(
          HomePageState(
            listAntrean: [],
            departemen: DefaultStateObj.instance.departemenDefault,
            antreanArgs: {
              'departemen': '',
              'pageno': '',
            },
            isEnd: false,
            isUpdate: false,
            pageNow: 0,
          ),
        );

  //======SET STATE======
  void setAntreanArgs(Map<String, dynamic> args, {isRefresh = false}) {
    if (isRefresh) {
      state = state.copyWith(
        antreanArgs: args,
      );
    } else {
      state.antreanArgs = args;
    }
  }

  void setListAntrean(List<AntreanModel> listAntreanModel,
      {isRefresh = false}) {
    if (isRefresh) {
      state = state.copyWith(
        listAntrean: listAntreanModel,
      );
    } else {
      state.listAntrean = listAntreanModel;
    }
  }

  void setDepartemen(DepartemenModel departemen, {isRefresh = false}) {
    if (isRefresh) {
      state = state.copyWith(departemen: departemen);
    } else {
      state.departemen = departemen;
    }
  }

  void refreshPage(WidgetRef ref) {
    //Clear List Antrean
    state.listAntrean.clear();

    //Invalidate provider
    ref.invalidate(
      antreanViewModel,
    );
  }
}
