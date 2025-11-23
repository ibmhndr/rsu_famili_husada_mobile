// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:dhealth_ttd/view_component/styles/buttons.dart';
// import 'package:dhealth_ttd/view_component/styles/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// void showDialogLogin(BuildContext context, WidgetRef ref) {
//   showDialog(
//     context: context,
//     useRootNavigator: true,
//     barrierDismissible: true,
//     builder: (dialogContext) {
//       return Dialog(
//         shadowColor: colorAccentGrey().withOpacity(0.2),
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Container(
//           constraints: BoxConstraints(
//               maxHeight: double.infinity,
//               minHeight: MediaQuery.of(context).size.height * 0.2),
//           width: MediaQuery.of(context).size.width,
//           child: CustomScrollView(
//             shrinkWrap: true,
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
//                 sliver: SliverToBoxAdapter(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       //@Title Padding
//                       ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         minVerticalPadding: 0,
//                         title: AutoSizeText(
//                           'Masuk',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           minFontSize: 16,
//                           maxFontSize: 18,
//                           textAlign: TextAlign.start,
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleSmall
//                               ?.copyWith(
//                                   color: colorBlack(),
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                         ),
//                         trailing: IconButton(
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                           splashRadius: 20,
//                           icon: const Icon(Icons.close),
//                           onPressed: () =>
//                               Navigator.of(dialogContext, rootNavigator: true)
//                                   .pop(),
//                         ),
//                       ),
//
//                       const SizedBox(
//                         height: 8,
//                       ),
//
//                       //@Login As User
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 //Pop Dialog
//                                 Navigator.of(context).pop();
//
//                                 //Navigate
//                                 Navigator.of(context).pushNamed(
//                                   LoginPage.routeName,
//                                   arguments: LoginPageArguments(
//                                     login: UserLogin.public,
//                                   ),
//                                 );
//                               },
//                               style: buttonSecondary(
//                                 12,
//                                 1.5,
//                                 0,
//                                 Theme.of(context).colorScheme.tertiary,
//                                 colorWhite(),
//                               ),
//                               icon: Icon(
//                                 MdiIcons.account,
//                                 color: Theme.of(context).colorScheme.tertiary,
//                               ),
//                               label: AutoSizeText(
//                                 'Masuk sebagai pengguna publik',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge
//                                     ?.copyWith(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .tertiary,
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       //@Login As Admin
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: () {
//                                 //Pop Dialog
//                                 Navigator.of(context).pop();
//
//                                 //Navigate
//                                 Navigator.of(context).pushNamed(
//                                   LoginPage.routeName,
//                                   arguments: LoginPageArguments(
//                                     login: UserLogin.admin,
//                                   ),
//                                 );
//                               },
//                               style: buttonCustom(
//                                 12,
//                                 0,
//                                 Theme.of(context).colorScheme.primary,
//                               ),
//                               icon: const Icon(
//                                 MdiIcons.accountTieWoman,
//                               ),
//                               label: const AutoSizeText(
//                                 'Masuk sebagai admin',
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
