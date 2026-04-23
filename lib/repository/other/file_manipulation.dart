import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';

class FileManipulation {
  //Singleton
  FileManipulation._privateConstructor();
  static final FileManipulation instance =
      FileManipulation._privateConstructor();
  factory FileManipulation() {
    return instance;
  }

  //======PHOTO METHOD======
  Future<String> getPathDirectoryNew() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  //Delete File
  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        if (kDebugMode) {
          print('Data File ${file.path} Deleted');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Delete File Error $e');
      }
    }
  }

  // //compress Photo file and get file.
  // Future<File> compressAndGetFile(
  //     String targetPath, List<File> dataFotoDelete) async {
  //   File photo = await FlutterNativeImage.compressImage(
  //     targetPath,
  //     quality: 50,
  //   );
  //
  //   //Add List Photo For Delete Later
  //   dataFotoDelete.add(File(targetPath));
  //
  //   //Return Photo
  //   if (kDebugMode) {
  //     print('Photo Size End Result : ${photo.lengthSync() / 1000}');
  //     print('Photo Path : ${photo.path}');
  //   }
  //   return photo;
  // }

  // //Check Compress Foto
  // Future<File> checkCompressPhoto(
  //     File dataFoto, List<File> dataFotoDelete) async {
  //   while (dataFoto.lengthSync() / 1000 > 1000) {
  //     dataFoto = await compressAndGetFile(
  //       dataFoto.path,
  //       dataFotoDelete,
  //     );
  //   }
  //   return dataFoto;
  // }

  // //Show Get File Modal Dialog
  // Future<List<dynamic>> showGetFileModal(BuildContext context, File file, List<File> fileDelete) async {
  //   showBarModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SizedBox(
  //         height: 115,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: <Widget>[
  //             //Foto Button
  //             ListTile(
  //               leading: const Icon(Icons.camera_alt),
  //               title: const AutoSizeText('Ambil foto'),
  //               onTap: () async {
  //                 if (kDebugMode) {
  //                   print('Tap Foto');
  //                 }
  //                 //Image Picker
  //                 ImagePicker image = ImagePicker();
  //                 XFile? xpicture = await image.pickImage(
  //                   imageQuality: 50,
  //                   source: ImageSource.camera,
  //                   preferredCameraDevice: CameraDevice.rear
  //                 );
  //
  //                 //Pop Modal Bottom
  //                 Navigator.pop(context);
  //
  //                 // If Data not null
  //                 if (xpicture != null) {
  //                   showToast("Mencoba mengambil foto");
  //
  //                   //Data Foto Identitas
  //                   fileDelete.add(File(xpicture.path));
  //                   //Rename Image
  //                   // context.read<SignUpProvider>().dataFotoIdentitas = await context.read<SignUpProvider>().renameFilePhoto(
  //                   //   File(xpicture.path),
  //                   // );
  //
  //                   //Add Photo Delete Before Rename
  //                   state.dataFoto = File(xpicture.path);
  //
  //                   //Data Foto Identitas Crop
  //                   state.dataFoto = await ImageCropper().cropImage(
  //                       sourcePath: state.dataFoto!.path,
  //                       aspectRatioPresets: [
  //                         CropAspectRatioPreset.square,
  //                         CropAspectRatioPreset.ratio3x2,
  //                         CropAspectRatioPreset.original,
  //                         CropAspectRatioPreset.ratio4x3,
  //                         CropAspectRatioPreset.ratio16x9
  //                       ],
  //                       androidUiSettings: const AndroidUiSettings(
  //                           toolbarTitle: 'Foto Identitas',
  //                           toolbarColor: Colors.black,
  //                           toolbarWidgetColor: Colors.white,
  //                           initAspectRatio: CropAspectRatioPreset.original,
  //                           lockAspectRatio: false),
  //                       iosUiSettings: const IOSUiSettings(
  //                         minimumAspectRatio: 1.0,
  //                       )
  //                   );
  //
  //                   //Add Photo Delete First
  //                   //context.read<SignUpProvider>().dataFotoIdentitasDelete.add(context.read<SignUpProvider>().dataFotoIdentitas!);
  //
  //                   //Print data info & foto size
  //                   if (kDebugMode) {
  //                     print('Photo Path Identitas : ${state.dataFoto!.path}');
  //                     print('Photo Size Identitas : ${state.dataFoto!.lengthSync()/1000} Bytes');
  //                     print('File Identitas ${xpicture.name}');
  //                   }
  //
  //                   //Check Compress Photo
  //                   try {
  //                     state.dataFoto = await checkCompressPhoto(
  //                         state.dataFoto!,
  //                         state.dataFotoDelete
  //                     );
  //                   } on Exception catch (e) {
  //                     throw ('Error On Compress Foto Identitas : $e');
  //                   }
  //
  //                   state = state.copyWith(
  //                     dataFoto: state.dataFoto,
  //                     dataFotoDelete: state.dataFotoDelete
  //                   );
  //                 }
  //                 //Else file not selected
  //                 else {
  //                   showToast("File tidak dipilih");
  //                   if (kDebugMode) {
  //                     print('File Kosong!/Tidak Dipilih');
  //                   }
  //                 }
  //               },
  //             ),
  //             //Galery Button
  //             ListTile(
  //               leading: const Icon(Icons.image),
  //               title: const Text('Ambil dari galery'),
  //               onTap: () async {
  //                 if (kDebugMode) {
  //                   print('Galery Foto');
  //                 }
  //                 //Image Picker
  //                 ImagePicker image = ImagePicker();
  //                 XFile? xpicture = await image.pickImage(
  //                   imageQuality: 50,
  //                   source: ImageSource.gallery,
  //                 );
  //
  //                 //Pop Modal Bottom
  //                 Navigator.pop(context);
  //
  //                 // If Data not null
  //                 if (xpicture != null) {
  //                   showToast("Mencoba mengambil foto");
  //                   if ((File(xpicture.path).lengthSync()/1000) < 10000) {
  //
  //                     //Data Foto Identitas
  //                     if (fotoGroup == 'fotoIdentitas') {
  //                       state.dataFotoDelete.add(File(xpicture.path));
  //                       //Rename Image
  //                       // context.read<SignUpProvider>().dataFotoIdentitas = await context.read<SignUpProvider>().renameFilePhoto(
  //                       //   File(xpicture.path),
  //                       // );
  //
  //                       //Add Photo Delete Before Rename
  //                       state.dataFoto = File(xpicture.path);
  //
  //                       //Data Foto Identitas Crop
  //                       state.dataFoto = await ImageCropper().cropImage(
  //                           sourcePath: state.dataFoto!.path,
  //                           aspectRatioPresets: [
  //                             CropAspectRatioPreset.square,
  //                             CropAspectRatioPreset.ratio3x2,
  //                             CropAspectRatioPreset.original,
  //                             CropAspectRatioPreset.ratio4x3,
  //                             CropAspectRatioPreset.ratio16x9
  //                           ],
  //                           androidUiSettings: const AndroidUiSettings(
  //                               toolbarTitle: 'Foto Identitas',
  //                               toolbarColor: Colors.black,
  //                               toolbarWidgetColor: Colors.white,
  //                               initAspectRatio: CropAspectRatioPreset.original,
  //                               lockAspectRatio: false),
  //                           iosUiSettings: const IOSUiSettings(
  //                             minimumAspectRatio: 1.0,
  //                           )
  //                       );
  //
  //                       //Add Photo Delete First
  //                       //context.read<SignUpProvider>().dataFotoIdentitasDelete.add(context.read<SignUpProvider>().dataFotoIdentitas!);
  //
  //                       //Print data info & foto size
  //                       if (kDebugMode) {
  //                         print('Photo Path Identitas : ${state.dataFoto!.path}');
  //                         print('Photo Size Identitas : ${state.dataFoto!.lengthSync()/1000} Bytes');
  //                         print('File Identitas ${xpicture.name}');
  //                       }
  //
  //                       //Check Compress Photo
  //                       try {
  //                         state.dataFoto = await checkCompressPhoto(
  //                             state.dataFoto!,
  //                             state.dataFotoDelete
  //                         );
  //                       } on Exception catch (e) {
  //                         throw ('Error On Compress Foto Identitas : $e');
  //                       }
  //                     }
  //                     else {
  //                       if (kDebugMode) {
  //                         print('Jenis foto tidak didapatkan');
  //                       }
  //                     }
  //
  //                     state = state.copyWith(
  //                         dataFotoDelete: state.dataFotoDelete,
  //                         dataFoto: state.dataFoto
  //                     );
  //                   }
  //                   //If Photo Size > 15.000KB
  //                   else {
  //                     showToast("Ukuran foto yang anda pilih terlalu besar (Max 10MB)");
  //                   }
  //                 }
  //                 //Else file not selected
  //                 else {
  //                   showToast("File tidak dipilih");
  //                   if (kDebugMode) {
  //                     print('File Kosong!/Tidak Dipilih');
  //                   }
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
//======PHOTO METHOD======

  //@Store file to storage
  Future<File?> storeFileFromNetwork(
      BuildContext context, Uint8List fileList, String filename,
      {bool isShowToast = true}) async {
    //Create file from raw path
    File file = File.fromRawPath(fileList);

    if (kDebugMode) {
      print("File Path test : ${file.path}");
    }

    //@Show Loading Dialog
    showLoaderDialogMessage(context, Theme.of(context).colorScheme.primary,
        'Mengunduh berkas', true);

    //@If Device is Android
    if (Platform.isAndroid) {
      try {
        String dir = '/storage/emulated/0/Download';

        file = File('$dir/$filename');
        if (kDebugMode) {
          print('File : $file');
        }
        await file.writeAsBytes(
          fileList,
          flush: true,
        );

        //@show toast according to input
        if (isShowToast) {
          showToast('Berkas berhasil tersimpan ke direktori download');
        }
        if (kDebugMode) {
          print('File berhasil tersimpan ke direktori');
        }

        //@Pop Dialog Download
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        //@Return saved file
        return file;
      } on Exception {
        showToast('Gagal menyimpan dokumen');
      }

      //UNKNOWN ERROR ACCESSING PERMISSION
      // //If Permission granted
      // if (await Permission.storage.request().isGranted &&
      //         // access media location needed for android 10/Q
      //         await Permission.accessMediaLocation.request().isGranted
      //     //Disable for privacy policy
      //     // &&
      //     // manage external storage needed for android 11/R
      //     // await Permission.manageExternalStorage.request().isGranted
      //     ) {
      //   try {
      //     String dir = '/storage/emulated/0/Download';
      //
      //     file = File('$dir/$filename');
      //     if (kDebugMode) {
      //       print('File : $file');
      //     }
      //     await file.writeAsBytes(fileList, flush: true);
      //
      //     //@show toast according to input
      //     if (isShowToast) {
      //       showToast('Berkas berhasil tersimpan ke direktori download');
      //     }
      //     if (kDebugMode) {
      //       print('File berhasil tersimpan ke direktori');
      //     }
      //
      //     //@Pop Dialog Download
      //     Navigator.of(context, rootNavigator: true).pop();
      //
      //     //@Return saved file
      //     return file;
      //   } on Exception {
      //     showToast('Gagal menyimpan dokumen');
      //   }
      // }
      // //Else Permission not granted
      // else {
      //   //Pop Loading
      //   Navigator.of(context, rootNavigator: true).pop();
      //   showConfirmDialog(
      //       context,
      //       'Simpan Berkas Gagal',
      //       'Perizinan untuk menyimpan berkas ke perangkat ditolak, mohon berikan izin untuk menyimpan berkas ke perangkat.',
      //       'OK',
      //       Theme.of(context).colorScheme.secondary,
      //       functionOnOk: () => openAppSettings());
      // }
    }
    //@Device Is Ios
    else if (Platform.isIOS) {
      try {
        Directory dir = await getApplicationDocumentsDirectory();

        if (kDebugMode) {
          print('Directory IOS : ${dir.path}');
        }

        file = File('${dir.path}/$filename');
        if (kDebugMode) {
          print('File : $file');
        }
        await file.writeAsBytes(fileList, flush: true);

        //@show toast according to input
        if (isShowToast)
          showToast('Berkas berhasil tersimpan ke direktori aplikasi');

        if (kDebugMode) {
          print('File berhasil tersimpan ke direktori');
        }

        //@Pop Dialog Download
        Navigator.of(context, rootNavigator: true).pop();

        //@Return saved File
        return file;
      } on Exception catch (e) {
        if (kDebugMode) {
          print('Gagal menyimpan dokumen : $e');
        }
        showToast('Gagal menyimpan dokumen');
      }
    }
    //@Else not android or ios
    else {
      showToast('Terjadi kesalahan mengunduh berkas');
    }

    //@Pop Dialog Download
    Navigator.of(context, rootNavigator: true).pop();

    //@Else return null
    return null;
  }
}
