import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:rsufamilyhusadacare_mobile/model/antrean_response.dart';
import 'package:rsufamilyhusadacare_mobile/model/departemen_response.dart';
import 'package:rsufamilyhusadacare_mobile/repository/other/check_dialog.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/asset_drawable/asset_image_drawable.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/data/default/default_state.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/string/string_data.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/widget/error_widget.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/reference.dart';

class HomePage extends HookConsumerWidget {
  static const routeName = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final homePageProvider = ref.watch(
      homePageViewModel,
    );
    final departemenPageProvider = ref.watch(departemenViewModel);
    final antreanPageProvider = ref.watch(
      antreanViewModel(
        homePageProvider.antreanArgs,
      ),
    );

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.read(homePageViewModel.notifier).refreshPage(ref),
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leadingWidth: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    bottom: 8,
                    right: 0,
                  ),
                  child: Image.asset(
                    AssetImageDrawable.logoRsSquarePng,
                    // fit: BoxFit.contain,
                  ),
                ),
                title: AutoSizeText(
                  'RSU Famili Husada Care',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
                ),
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size(
                    MediaQuery.of(context).size.width,
                    40,
                  ),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            '${dateTimeDayData['${DateTime.now().weekday}']}, ${DateTime.now().day} ${dateTimeMonthData['${DateTime.now().month}']} ${DateTime.now().year}',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: colorWhite(),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  departemenPageProvider.when(
                    loading: () => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: cardSkeletonCircle(
                          context,
                        ),
                      ),
                    ),
                    error: (error, stackTrace) {
                      if (kDebugMode) {
                        print(
                          "Terjadi kegagalan memperoleh data departemen (error : $error, stackTrace : $stackTrace)",
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: cardSkeletonCircle(
                            context,
                          ),
                        ),
                      );
                    },
                    data: (dataDepartemen) => IconButton(
                      onPressed: () async {
                        try {
                          //Show loader
                          showLoaderDialogMessage(
                            context,
                            Theme.of(context).colorScheme.primary,
                            MessageDialog.loadingMessage,
                            true,
                          );

                          if (context.mounted) {
                            //Pop Loader
                            Navigator.of(context, rootNavigator: true).pop();

                            //Navigate to survey
                            searchDialog(
                              context,
                              ref,
                              dataDepartemen.result,
                              homePageProvider.departemen,
                              searchController,
                            );
                          }
                        } on Exception catch (e, s) {
                          if (kDebugMode) {
                            print(
                                "Terjadi kegagalan memperoleh data Penyuluhan Hukum (error: $e, stackTrce : $s)");
                          }

                          //Check if any dialog showing
                          if (isDialogShowing(context)) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.filter_list,
                      ),
                    ),
                  )
                ],
              ),

              //Data
              SliverPadding(
                padding: const EdgeInsets.all(
                  16,
                ),
                sliver: SliverToBoxAdapter(
                  child: antreanPageProvider.when(
                    loading: () => Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        10,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16.0,
                          ),
                          child: SizedBox(
                            height: 350,
                            child: cardSkeletonRectangleRadius(
                              context,
                              12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    error: (error, stackTrace) {
                      if (kDebugMode) {
                        print(
                          "Terjadi kegagalan memperoleh data antrean (erro : $error, stackTrace : $stackTrace),",
                        );
                      }

                      return errorWidgetPage(context);
                    },
                    data: (dataAntrean) {
                      if (homePageProvider.listAntrean.isEmpty) {
                        ref.read(homePageViewModel.notifier).setListAntrean(
                              dataAntrean.result,
                            );
                      }

                      List<String> listDeptAvailable = homePageProvider
                          .listAntrean
                          .map((element) => element.deptName)
                          .whereType<String>()
                          .toSet()
                          .toList();

                      if (kDebugMode) {
                        print("List Dept Available : $listDeptAvailable");
                      }

                      if ((homePageProvider.listAntrean.isEmpty)) {
                        return errorWidgetPage(context);
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            listDeptAvailable.length,
                            (indexDept) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //Label Title
                                  Center(
                                    child: AutoSizeText(
                                      listDeptAvailable[indexDept],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),

                                  //Builder for data foreach department
                                  Builder(builder: (context) {
                                    List<AntreanModel> listDataAntreanDokter =
                                        homePageProvider.listAntrean
                                            .map((e) {
                                              if (e.deptName ==
                                                  listDeptAvailable[
                                                      indexDept]) {
                                                return e;
                                              }

                                              return null;
                                            })
                                            .whereType<AntreanModel>()
                                            .toList();

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        listDataAntreanDokter.length,
                                        (indexDokter) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: Card(
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                            shadowColor:
                                                colorAccentGrey().withOpacity(
                                              0.2,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  //Profile
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      //Photo
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          //Image
                                                          SizedBox(
                                                            height: 200,
                                                            width: 120,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                16,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                listDataAntreanDokter[
                                                                            indexDokter]
                                                                        .pegPhoto ??
                                                                    '',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                        width: 16,
                                                      ),

                                                      //Label
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            //Name
                                                            AutoSizeText(
                                                              listDataAntreanDokter[
                                                                          indexDokter]
                                                                      .pegName ??
                                                                  '',
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(),
                                                            ),

                                                            const SizedBox(
                                                              height: 4,
                                                            ),

                                                            //Spesialis
                                                            AutoSizeText(
                                                              listDataAntreanDokter[
                                                                          indexDokter]
                                                                      .drspName ??
                                                                  '',
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                    color:
                                                                        colorAccentGrey(),
                                                                  ),
                                                            ),

                                                            const SizedBox(
                                                              height: 12,
                                                            ),

                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                //Pasien Belum Datang
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Belum Datang',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    CircleAvatar(
                                                                      maxRadius:
                                                                          12,
                                                                      backgroundColor:
                                                                          colorBlue(),
                                                                      child:
                                                                          AutoSizeText(
                                                                        listDataAntreanDokter[indexDokter].pasienBelumDatang ??
                                                                            '0',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                              color: colorWhite(),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                const SizedBox(
                                                                  height: 6,
                                                                ),

                                                                //Pasien Belum Diperiksa
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Belum Diperiksa',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    CircleAvatar(
                                                                      maxRadius:
                                                                          12,
                                                                      backgroundColor:
                                                                          colorAccentGreen(),
                                                                      child:
                                                                          AutoSizeText(
                                                                        listDataAntreanDokter[indexDokter].pasienDatangBelumDiperiksa ??
                                                                            '0',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                              color: colorWhite(),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                const SizedBox(
                                                                  height: 6,
                                                                ),

                                                                //Pasien Sudah Diperiksa
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Sudah Diperiksa',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    CircleAvatar(
                                                                      maxRadius:
                                                                          12,
                                                                      backgroundColor:
                                                                          colorAccentOrange(),
                                                                      child:
                                                                          AutoSizeText(
                                                                        listDataAntreanDokter[indexDokter].pasienSudahDiperiksa ??
                                                                            '0',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                              color: colorWhite(),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                const SizedBox(
                                                                  height: 6,
                                                                ),

                                                                //Pasien Pulang
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Pulang',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    CircleAvatar(
                                                                      maxRadius:
                                                                          12,
                                                                      backgroundColor:
                                                                          colorAccentRed(),
                                                                      child:
                                                                          AutoSizeText(
                                                                        listDataAntreanDokter[indexDokter].pasienPulang ??
                                                                            '0',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                              color: colorWhite(),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                const SizedBox(
                                                                  height: 6,
                                                                ),

                                                                //Pasien Batal / Pulang
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Batal / Tidak Datang',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    CircleAvatar(
                                                                      maxRadius:
                                                                          12,
                                                                      backgroundColor:
                                                                          colorAccentGrey(),
                                                                      child:
                                                                          AutoSizeText(
                                                                        listDataAntreanDokter[indexDokter].tidakDatang ??
                                                                            '0',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodySmall
                                                                            ?.copyWith(
                                                                              fontSize: 8,
                                                                              color: colorWhite(),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(
                                                    height: 8,
                                                  ),

                                                  Divider(
                                                    thickness: 1,
                                                    color: colorAccentGrey()
                                                        .withOpacity(
                                                      0.3,
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    height: 8,
                                                  ),

                                                  //Label No Antrean
                                                  AutoSizeText(
                                                    'Nomor Antrean',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall
                                                        ?.copyWith(),
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.start,
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment
                                                  //           .start,
                                                  //   mainAxisSize:
                                                  //       MainAxisSize.min,
                                                  //   children: [
                                                  //     badges.Badge(
                                                  //       badgeContent:
                                                  //           AutoSizeText(
                                                  //         listDataAntreanDokter[
                                                  //                     indexDokter]
                                                  //                 .ralanNoantrian ??
                                                  //             '',
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         style:
                                                  //             Theme.of(context)
                                                  //                 .textTheme
                                                  //                 .bodySmall
                                                  //                 ?.copyWith(
                                                  //                   fontSize: 4,
                                                  //                   // color:
                                                  //                   //     colorWhite(),
                                                  //                 ),
                                                  //       ),
                                                  //       badgeStyle:
                                                  //           badges.BadgeStyle(
                                                  //         badgeColor:
                                                  //             Theme.of(context)
                                                  //                 .colorScheme
                                                  //                 .secondary,
                                                  //       ),
                                                  //       position:
                                                  //           badges.BadgePosition
                                                  //               .topEnd(
                                                  //         end: ((listDataAntreanDokter[indexDokter]
                                                  //                             .ralanNoantrian ??
                                                  //                         '')
                                                  //                     .length >
                                                  //                 1)
                                                  //             ? -28
                                                  //             : -20,
                                                  //         top: -10,
                                                  //       ),
                                                  //       child: AutoSizeText(
                                                  //         'Nomor Antrean',
                                                  //         maxLines: 1,
                                                  //         overflow: TextOverflow
                                                  //             .ellipsis,
                                                  //         style:
                                                  //             Theme.of(context)
                                                  //                 .textTheme
                                                  //                 .labelSmall
                                                  //                 ?.copyWith(),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),

                                                  const SizedBox(
                                                    height: 8,
                                                  ),

                                                  //No Antrean
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // //Label No Antrean Sedang diperiksa
                                                      // CircleAvatar(
                                                      //   child: AutoSizeText(
                                                      //     listDataAntreanDokter[
                                                      //                 indexDokter]
                                                      //             .ralanNoantrian ??
                                                      //         '',
                                                      //     overflow: TextOverflow
                                                      //         .ellipsis,
                                                      //     style:
                                                      //         Theme.of(context)
                                                      //             .textTheme
                                                      //             .headlineSmall
                                                      //             ?.copyWith(),
                                                      //   ),
                                                      // ),
                                                      //
                                                      // const SizedBox(
                                                      //   width: 12,
                                                      // ),

                                                      //Data
                                                      Expanded(
                                                        child: Wrap(
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          spacing: 4,
                                                          runSpacing: 6,
                                                          children:
                                                              List.generate(
                                                            listDataAntreanDokter[
                                                                    indexDokter]
                                                                .antre
                                                                .length,
                                                            (indexAntrean) =>
                                                                Container(
                                                              height: 25,
                                                              width: 30,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 4,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                4,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: listColorAntrean[listDataAntreanDokter[
                                                                              indexDokter]
                                                                          .antre[
                                                                              indexAntrean]
                                                                          .status ??
                                                                      '']),
                                                              child:
                                                                  AutoSizeText(
                                                                ((listDataAntreanDokter[indexDokter].antre[indexAntrean].noAntre ??
                                                                                '')
                                                                            .length >
                                                                        1)
                                                                    ? (listDataAntreanDokter[indexDokter]
                                                                            .antre[indexAntrean]
                                                                            .noAntre ??
                                                                        '')
                                                                    : '0${listDataAntreanDokter[indexDokter].antre[indexAntrean].noAntre ?? ''}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                minFontSize: 8,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall
                                                                    ?.copyWith(
                                                                      color:
                                                                          colorWhite(),
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),

                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    skipLoadingOnRefresh: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorWidgetPage(BuildContext context) {
    return errorWidgetUndraw(
      context,
      FailedMessage.headerError,
      FailedMessage.bodyRefresh,
      crossAxisAlignment: CrossAxisAlignment.center,
      widgetImage: UnDraw(
        color: Theme.of(context).colorScheme.primary,
        illustration: UnDrawIllustration.load_more,
        placeholder:
            const SizedBox(), //optional, default is the CircularProgressIndicator().
        errorWidget:
            const SizedBox(), //optional, default is the Text('Could not load illustration!').
      ),
    );
  }

  //@Change Show Name
  //@Change Show Name
  Future<void> searchDialog(
    BuildContext context,
    WidgetRef ref,
    List<DepartemenModel> listBahasa,
    DepartemenModel departemenInit,
    TextEditingController searchController,
  ) async {
    late BuildContext dialogData;
    DepartemenModel departemen = departemenInit;

    // KategoriSuluhSuaraModel kategoriSuluhSuaraModel =
    //     DefaultStateObj.instance.kategoriSuluhSuaraDefault;
    // KategoriTipeSuluhSuaraModel kategoriTipeSuluhSuaraModel =
    //     DefaultStateObj.instance.kategoriTipeSuluhSuaraAltDefault;
    // Map<String, dynamic> kategoriTipeSuluhSuaraArgs = {'kat_id': ''};

    Dialog dialog = Dialog(
      shadowColor: colorAccentGrey().withOpacity(0.2),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: MediaQuery.of(context).size.height * 0.1,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    //@Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //@Title
                        AutoSizeText(
                          'Filter',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 18),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //@Form Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // @Kata Kunci
                        AutoSizeText(
                          'Kata Kunci',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 12,
                          maxFontSize: 14,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: colorBlack(),
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: searchController,
                          maxLines: 1,
                          minLines: 1,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            hintText: 'Contoh : Dr...',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2.0),
                                borderRadius: BorderRadius.circular(12)
                                //borderRadius: BorderRadius.circular(25.0)
                                ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(12)
                                //borderRadius: BorderRadius.circular(25.0)
                                ),
                          ),
                          // validator: ValidationBuilder(
                          //         requiredMessage: 'Bagian ini wajib diisi')
                          //     .build(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        //@Bahasa
                        AutoSizeText(
                          'Departemen',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 12,
                          maxFontSize: 14,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: colorBlack(),
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        StatefulBuilder(
                          builder: (context, setState) =>
                              DropdownSearch<DepartemenModel>(
                            popupProps: PopupProps.modalBottomSheet(
                              showSearchBox: true,
                              disabledItemFn: (item) {
                                //@Check if there is checked item
                                //@Check if there is checked item
                                if (item.deptId.toString() ==
                                    departemen.deptId.toString()) {
                                  return true;
                                }

                                return false;
                              },
                              modalBottomSheetProps:
                                  const ModalBottomSheetProps(),
                            ),
                            enabled: true,
                            // validator: (value) {
                            //   if (value == null) {
                            //     return "Bagian ini wajib diisi";
                            //   } else if (value.label == 'Pilih jenis') {
                            //     return "Bagian ini wajib diisi";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            items: listBahasa,
                            // asyncItems: (text) async {
                            //   return ref.read(forgotAbsencePageViewModel.notifier).searchVerifikator(text);
                            // },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: DefaultStateObj
                                    .instance.departemenDefault.deptName,
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                labelStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(12)
                                    //borderRadius: BorderRadius.circular(25.0)
                                    ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(12)
                                    //borderRadius: BorderRadius.circular(25.0)
                                    ),
                              ),
                            ),
                            itemAsString: (item) => item.getDepartemenName(),
                            onChanged: (result) {
                              //@Change if result not null
                              if (result != null) {
                                setState(() {
                                  departemen = result;
                                });
                              }

                              // if (kDebugMode) {
                              //   print("${forgotAbsenceProvider.listUsedVerifikator[0].pegNama}");
                              // }
                            },
                            selectedItem: departemen, //selected to show
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        // // @Alamat
                        // AutoSizeText(
                        //   'Alamat',
                        //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        //       // color: colorAccentGrey(),
                        //       ),
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.width * 0.01,
                        // ),
                        // TextFormField(
                        //   controller: alamatController,
                        //   maxLines: 1,
                        //   minLines: 1,
                        //   decoration: InputDecoration(
                        //     labelStyle: const TextStyle(color: Colors.grey),
                        //     filled: true,
                        //     fillColor: Colors.grey.shade200,
                        //     hintText: 'Contoh : Jalan...',
                        //     focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Theme.of(context).colorScheme.primary,
                        //           width: 2.0,
                        //         ),
                        //         borderRadius: BorderRadius.circular(12)),
                        //     border: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //             color: Colors.grey.shade200, width: 2.0),
                        //         borderRadius: BorderRadius.circular(12)
                        //         //borderRadius: BorderRadius.circular(25.0)
                        //         ),
                        //     enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey.shade200),
                        //         borderRadius: BorderRadius.circular(12)
                        //         //borderRadius: BorderRadius.circular(25.0)
                        //         ),
                        //   ),
                        //   validator: ValidationBuilder(
                        //           requiredMessage: 'Bagian ini wajib diisi')
                        //       .build(),
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.width * 0.05,
                        // ),

                        // //Kategori Tipe SuluhSuara
                        // AutoSizeText(
                        //   'Kategori Tipe SuluhSuara',
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.width * 0.03,
                        // ),
                        // Builder(builder: (context) {
                        //   final kategoriTipeFutureProvider = ref.watch(
                        //     kategoriTipeFutureDataViewModel(
                        //         kategoriTipeSuluhSuaraArgs),
                        //   );
                        //
                        //   return kategoriTipeFutureProvider.when(
                        //     loading: () => textFieldLoadingWidget(context),
                        //     error: (error, stackTrace) {
                        //       if (kDebugMode) {
                        //         print(
                        //             "Terjadi kegagalan memperoleh data kategori tipe SuluhSuara (error: $error, stackTrace: $stackTrace)");
                        //       }
                        //
                        //       return textFieldLoadingWidget(context);
                        //     },
                        //     data: (data) =>
                        //         DropdownSearch<KategoriTipeSuluhSuaraModel>(
                        //       popupProps: PopupProps.modalBottomSheet(
                        //         showSearchBox: true,
                        //         disabledItemFn: (item) {
                        //           //@Check if there is checked item
                        //           if (kategoriTipeSuluhSuaraModel.ktipeId ==
                        //               item.ktipeId) {
                        //             return true;
                        //           }
                        //
                        //           return false;
                        //         },
                        //         modalBottomSheetProps:
                        //             const ModalBottomSheetProps(),
                        //       ),
                        //       enabled: true,
                        //       validator: (value) {
                        //         if (value == null) {
                        //           return "Bagian ini wajib diisi";
                        //         } else if (value.ktipeId ==
                        //             DefaultStateObj.instance
                        //                 .kategoriTipeSuluhSuaraDefault.ktipeId) {
                        //           return "Bagian ini wajib diisi";
                        //         } else {
                        //           return null;
                        //         }
                        //       },
                        //       items: data.result,
                        //       dropdownDecoratorProps: DropDownDecoratorProps(
                        //         dropdownSearchDecoration: InputDecoration(
                        //           hintText: DefaultStateObj.instance
                        //               .kategoriTipeSuluhSuaraDefault.ktipeNama,
                        //           enabled: true,
                        //           filled: true,
                        //           fillColor: textFieldColor(),
                        //           suffixIcon: Icon(
                        //             Icons.arrow_drop_down_sharp,
                        //             color: Colors.black.withOpacity(0.6),
                        //           ),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderSide: BorderSide(
                        //                   color:
                        //                       Theme.of(context).colorScheme.primary,
                        //                   width: 2.0),
                        //               borderRadius: BorderRadius.circular(12)),
                        //           border: OutlineInputBorder(
                        //               borderSide: BorderSide(
                        //                   color: textFieldColor(), width: 2.0),
                        //               borderRadius: BorderRadius.circular(12)
                        //               //borderRadius: BorderRadius.circular(25.0)
                        //               ),
                        //           enabledBorder: OutlineInputBorder(
                        //               borderSide:
                        //                   BorderSide(color: textFieldColor()),
                        //               borderRadius: BorderRadius.circular(12)
                        //               //borderRadius: BorderRadius.circular(25.0)
                        //               ),
                        //         ),
                        //       ),
                        //       itemAsString: (item) => item.getKategoriTipeNama(),
                        //       onChanged: (result) {
                        //         //@Change if result not null
                        //         if (result != null) {
                        //         }
                        //       },
                        //       selectedItem:
                        //           kategoriTipeSuluhSuaraModel, //selected to show
                        //     ),
                        //   );
                        // }),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),

                        //@Button Change
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //@Telusuri button
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton.icon(
                                  style: buttonCustom(12, 3,
                                      Theme.of(context).colorScheme.primary),
                                  onPressed: () async {
                                    //@Pop Dialog
                                    Navigator.of(dialogData).pop();

                                    ref
                                        .read(homePageViewModel.notifier)
                                        .setDepartemen(
                                          departemen,
                                        );

                                    //@Set args
                                    ref
                                        .read(homePageViewModel.notifier)
                                        .setAntreanArgs(
                                      {
                                        'pageno': '1',
                                        'keyword': searchController.text,
                                        'departemen': departemen.deptId,
                                      },
                                    );

                                    //Refresh to clear data
                                    ref
                                        .read(homePageViewModel.notifier)
                                        .refreshPage(ref);
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: colorWhite(),
                                  ),
                                  label: AutoSizeText(
                                    'Telusuri',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: colorWhite()),
                                  )),
                            ),
                            //@Spacing
                            const SizedBox(
                              height: 16,
                            ),
                            //@Reset Button
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton.icon(
                                  style: buttonSecondary(
                                      12,
                                      1.5,
                                      1,
                                      Theme.of(context).colorScheme.primary,
                                      colorAccentWhite()),
                                  onPressed: () async {
                                    //@Pop Dialog
                                    Navigator.of(dialogData).pop();

                                    //@Reset
                                    searchController.text = '';
                                    ref
                                        .read(homePageViewModel.notifier)
                                        .setDepartemen(
                                          DefaultStateObj
                                              .instance.departemenDefault,
                                        );

                                    //@Set args
                                    ref
                                        .read(homePageViewModel.notifier)
                                        .setAntreanArgs(
                                      {
                                        'pageno': '1',
                                        'keyword': searchController.text,
                                        'departemen': '',
                                      },
                                    );

                                    //refresh page
                                    ref
                                        .read(homePageViewModel.notifier)
                                        .refreshPage(ref);
                                  },
                                  icon: Icon(Icons.youtube_searched_for,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  label: AutoSizeText(
                                    'Reset',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    //@Show dialog
    showDialog(
      context: context,
      builder: (dialogContext) {
        dialogData = dialogContext;
        return WillPopScope(
            onWillPop: () async => true, //false
            child: dialog);
      },
    );
  }
}
