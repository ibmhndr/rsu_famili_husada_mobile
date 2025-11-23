import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class InternetDownloadHelper {
  static Future<Uint8List?> loadFileFromNetworkCache(
      context, String fileUrl) async {
    if (kDebugMode) {
      print('Url Download : $fileUrl');
    }
    return _loadFileWithCache(context, fileUrl);
  }

  //@Load file
  static Future<Uint8List?> _loadFileWithCache(
      BuildContext context, String fileUrl) async {
    try {
      //@Get Directory Save File
      final tempDirectory = await getTemporaryDirectory();
      if (kDebugMode) {
        print('Directory : ${tempDirectory.path}');
        print('File String : $fileUrl');
      }

      //@Get pdf from internet
      final storageIO = InternetFileStorageIO();
      Uint8List? fileTTE = await storageIO.findExist(fileUrl, {
        'filename': path.basename(fileUrl),
        'location': tempDirectory.path,
      });

      //@File Not Found, Create File
      if (fileTTE != null) {
        return fileTTE;
      } else {
        //@Get New File TTE
        Uint8List fileTTENew = await InternetFile.get(
          fileUrl,
          storage: storageIO,
          storageAdditional: {
            'filename': path.basename(fileUrl),
            'location': tempDirectory.path,
          },
          progress: (receivedLength, contentLength) {},
        );

        return fileTTENew;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Terjadi kegagalan memperoleh berkas surat : $e');
      }

      return null;
    }
  }

  static Future<Uint8List> loadFileFromNetwork(context, String fileUrl) async {
    if (kDebugMode) {
      print('Url Download : $fileUrl');
    }
    return _loadFileWithoutCache(context, fileUrl);
  }

  //@Load file Without Cache
  static Future<Uint8List> _loadFileWithoutCache(
      BuildContext context, String fileUrl) async {
    try {
      if (kDebugMode) {
        print('File String : $fileUrl');
      }

      //@Get New File TTE
      Uint8List fileTTENew = await InternetFile.get(
        fileUrl,
        progress: (receivedLength, contentLength) {},
      );

      return fileTTENew;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Terjadi kegagalan memperoleh berkas surat : $e');
      }

      return Future.delayed(
        Duration.zero,
        () => Uint8List(
          0,
        ),
      );
    }
  }

// //@Store file to storage
// static Future<void> storeFileFromNetwork(
//     BuildContext context, Uint8List fileList, String filename) async {
//   File file = File.fromRawPath(fileList);
//
//   //@If Device is Android
//   if (Platform.isAndroid) {
//     //If Permission granted
//     if (await Permission.storage.request().isGranted &&
//             // access media location needed for android 10/Q
//             await Permission.accessMediaLocation.request().isGranted
//         //Disable for privacy policy
//         // &&
//         // manage external storage needed for android 11/R
//         // await Permission.manageExternalStorage.request().isGranted
//         ) {
//       try {
//         String dir = '/storage/emulated/0/Download';
//
//         file = File('$dir/$filename');
//         if (kDebugMode) {
//           print('File : $file');
//         }
//         try {
//           await file.writeAsBytes(fileList, flush: true);
//           showToast('Berkas berhasil tersimpan ke direktori download');
//           if (kDebugMode) {
//             print('File berhasil tersimpan ke direktori');
//           }
//         } on Exception catch (e) {
//           if (kDebugMode) {
//             print('Gagal menulis file pada $dir : $e');
//           }
//         }
//       } on Exception {
//         showToast('Gagal menyimpan dokumen');
//       }
//     }
//     //Else Permission not granted
//     else {
//       //Pop Loading
//       if (context.mounted) {
//         if (isDialogShowing(context)) {
//           Navigator.of(context, rootNavigator: true).pop();
//         }
//         showConfirmDialog(
//             context,
//             'Proses Cetak Gagal',
//             'Perizinan untuk menyimpan dokumen ke perangkat tidak aktif, mohon izinkan aplikasi menyimpan dokumen ke perangkat untuk melanjutkan.',
//             'OK',
//             Theme.of(context).colorScheme.primary,
//             functionOnOk: () => openAppSettings());
//       }
//     }
//   }
//
//   //@Device Is Ios
//   else if (Platform.isIOS) {
//     try {
//       Directory dir = await getApplicationDocumentsDirectory();
//
//       if (kDebugMode) {
//         print('Directory IOS : ${dir.path}');
//       }
//
//       file = File('${dir.path}/$filename');
//       if (kDebugMode) {
//         print('File : $file');
//       }
//       try {
//         await file.writeAsBytes(fileList, flush: true);
//         showToast('Berkas berhasil tersimpan ke direktori aplikasi');
//         if (kDebugMode) {
//           print('File berhasil tersimpan ke direktori');
//         }
//       } on Exception catch (e) {
//         if (kDebugMode) {
//           print('Gagal menulis file pada $dir : $e');
//         }
//       }
//     } on Exception catch (e) {
//       if (kDebugMode) {
//         print('Gagal menyimpan dokumen : $e');
//       }
//       showToast('Gagal menyimpan dokumen');
//     }
//   }
//
//   // return file;
// }
}
