//@
class HeaderDialog {
  // HeaderDialog._privateConstructor();
  // static final instance = HeaderDialog._privateConstructor();
  // factory HeaderDialog() {
  //   return instance;
  // }

  static String popDialog(String data) {
    return "Pembatalan $data";
  }

  //@Register
  static String confirmDialog(String data) {
    return "Konfirmasi $data";
  }

  static String confirmCancel(String data) {
    return "Konfirmasi Batal $data";
  }

  //@Header Dialog
  static String informasi = "Informasi";
  static String errorPengajuanDialog(String data) {
    return "Gagal Mengajukan $data";
  }

  static String errorGetData(String data) {
    return "Gagal Mengambil $data";
  }

  static String errorAksesDialog(String data) {
    return "Gagal Mengakses $data";
  }

  static String errorSendData(String data) {
    return "Gagal Mengirim $data";
  }

  //@Pengaduan Detail Page
  static String confirmDeleteData(String data) {
    return "Konfirmasi Hapus $data";
  }

  //@Delete
  static String confirmHeaderDelete(String data) {
    return "Konfirmasi Hapus $data";
  }

  static String successDialog(String data) {
    return "Anda Berhasil $data";
  }
}

class StringData {
  StringData._privateConstructor();
  static final instance = StringData._privateConstructor();
  factory StringData() {
    return instance;
  }

  //@Register
  static String confirmDialog(String data) {
    return "Konfirmasi $data";
  }

  static String confirmCancel(String data) {
    return "Konfirmasi Batal $data";
  }

  //@Header Dialog
  static String informasi = "Informasi";
  static String errorPengajuanDialog(String data) {
    return "Gagal Mengajukan $data";
  }

  static String errorAksesDialog(String data) {
    return "Gagal Mengakses $data";
  }

  static String errorSendData(String data) {
    return "Gagal Mengirim $data";
  }

  //@Pengaduan Detail Page
  static String confirmDeleteData(String data) {
    return "Konfirmasi Hapus $data";
  }

  //@Delete
  static String confirmHeaderDelete(String data) {
    return "Konfirmasi Hapus $data";
  }
}

class MessageDialog {
  //Menu Development
  static String menuIsInDevelopment = "Menu sedang dalam tahap pengembangan";
  //@Developer Option
  static String developerOptionMessage =
      "Anda terdeteksi aktif menggunakan mode pengembang / akses root / simulator, mohon non-aktifkan semua mode/akses untuk melanjutkan";
  //@Exit
  static String exitMessage = "Apakah anda yakin ingin keluar dari aplikasi?";
  static String dataNotFound(String data) {
    return "$data tidak ditemukan";
  }

  //@Permission
  static String permissionDisabled(String data) {
    return "Izin untuk memperoleh akses $data telah ditolak, mohon aktifkan perizinan untuk dapat melanjutkan";
  }

  static String accessDisabled(String data) {
    return "Akses $data ditolak, mohon aktifkan fitur untuk dapat melanjutkan";
  }

  static String noDataAvailable(String data) {
    return "Absensi tidak dapat dilanjutkan karena tidak ada $data tersedia";
  }

  static String cantTakeData(String data) {
    return "Terjadi gangguan saat akan mengambil $data, mohon informasikan ke pihak terkait";
  }

  //@Confirm Changes
  static String confirmChanges = "Apakah seluruh data telah sesuai ?";
  static String confirmCancelProcess = "Apakah anda yakin ingin membatalkan ?";

  //@Loading dialog
  static String loadingMessage = "Mohon tunggu";

  //@Register Page
  static String successRegister = "Berhasil melakukan pendaftaran";
  static String failedRegister =
      "Terjadi kegagalan saat mendaftar, mohon ulangi kembali dalam beberapa saat";

  //@Sms Verification page
  static String failedSmsOtp =
      "Gagal memverifikasi pesan otp, mohon ulangi kembali";

  //@Failed get url
  static String invalidUrl = "Akses url tidak diizinkan";

  //Success Log Out
  static String successLogOut = "Terima kasih telah menggunakan aplikasi";

  //@Failed Get
  static String failedGet(String data) {
    return "Gagal memperoleh data $data, mohon coba kembali dalam beberapa saat";
  }

  //@Failed Set
  static String failedSet(String data) {
    return "Gagal mengubah data $data, mohon coba kembali dalam beberapa saat";
  }

  static String failedSend(String data) {
    return "Gagal mengirim data $data, mohon coba kembali dalam beberapa saat";
  }

  static String failedAccess(String data) {
    return "Gagal mengakses $data, mohon coba kembali dalam beberapa saat";
  }

  static String failedDownload(String data) {
    return "Gagal mengunduh data $data, mohon coba kembali dalam beberapa saat";
  }

  static String failedOpen(String data, String solution) {
    return "Gagal membuka $data, $solution";
  }

  static String failedNonactive(String data) {
    return "$data gagal dinonaktifkan, mohon coba beberapa saat lagi";
  }

  //@Edit Profile
  static String errorAccess(String data) {
    return "Terjadi kegagalan mengakses data $data, mohon ulangi kembali dalam beberapa saat";
  }

  static String successEdit(String data) {
    return "$data berhasil diubah";
  }

  static String failedEdit(String data) {
    return "Terjadi kegagalan mengubah data $data, mohon ulangi kembali dalam beberapa saat";
  }

  //@Pengaduan Tindak Lanjut oleh SKPD
  static String successSend(String data) {
    return "$data berhasil dikirim";
  }

  static String successNonactive(String data) {
    return "$data berhasil dinonaktifkan";
  }

  //@Delete data
  static String confirmBodyDelete(String data) {
    return "Apakah anda yakin ingin menghapus $data ?";
  }

  static String successDelete(String data) {
    return "$data berhasil dihapus";
  }

  static String failedDelete(String data) {
    return "$data gagal dihapus, mohon coba kembali dalam beberapa saat";
  }

  //@verify data
  static String confirmBodyVerify(String data) {
    return "Apakah anda yakin ingin memverifikasi $data ?";
  }

  static String successVerify(String data) {
    return "$data berhasil diverifikasi";
  }

  static String failedVerify(String data) {
    return "$data gagal diverifikasi, mohon coba kembali dalam beberapa saat";
  }

  //@rollback data
  static String confirmBodyRollback(String data) {
    return "Apakah anda yakin ingin melakukan rollback $data ?";
  }

  static String successRollback(String data) {
    return "$data berhasil dirollback";
  }

  static String failedRollback(String data) {
    return "$data gagal dirollback, mohon coba kembali dalam beberapa saat";
  }

  static String dataNotFoundRefresh(String data) {
    return "$data tidak ditemukan, usap layar ke bawah untuk refresh";
  }

  static String dataNotFoundPleaseAdd(String data) {
    return "$data tidak ditemukan, silahkan tambah data untuk melihat";
  }

  static String dataNotFoundContactAdmin(String data) {
    return "$data tidak ditemukan, mohon hubungi admin aplikasi";
  }

  static String invalidTime(String data) {
    return "Waktu tidak sesuai, $data";
  }

  static String confirmCancelProcessData(String data) =>
      "Apakah anda yakin ingin membatalkan $data ?";

  static String confirmProcessData(String data) =>
      "Apakah anda yakin ingin $data ?";

  static String confirmSendForm(String data) =>
      "Apakah seluruh $data telah sesuai ?";
}

class ErrorDialog {
  static String errorNamaTampil =
      "Gagal Mengubah Nama Tampil, mohon coba beberapa saat lagi";
  static String errorFilesNotSelected(String data) {
    return "$data masih kosong, mohon isi ${data.toLowerCase()} untuk melanjutkan";
  }
}

class ActionDialog {
  static String ok = "OK";
  static String ya = "Ya";
  static String tidak = "Tidak";
}

//@Messages like loading etc
class FailedMessage {
  static String headerError = "Data Tidak Ditemukan";
  static String bodyRefresh = "Guliar layar kebawah untuk memperbarui data";
  static String errorGetData(String data) {
    return "Terjadi kegagalan memperoleh data $data, ulangi kembali dalam beberapa saat";
  }

  static String dataNotFound(String data) {
    return "$data tidak ditemukan";
  }
}

//@Toast Message
class ToastMessage {
  // static String changeLocationFailed = "Gagal memperoleh lokasi";
  static String internetError =
      "Terjadi kegagalan mengakses internet, pastikan internet anda sudah aktif";
  static String changeLocationFailed = "Gagal memperoleh lokasi";
  static String mohonTunggu = "Sedang mencari data, mohon tunggu";
  static String dataNotFound(String data) {
    return "$data tidak ditemukan";
  }

  static String errorGettingData(String data) {
    return "Terjadi gangguan memperoleh data $data";
  }

  static String errorPostingData(String data) {
    return "Terjadi gangguan mengirim data $data";
  }
}
