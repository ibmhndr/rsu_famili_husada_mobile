import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/widget/error_widget.dart';

class ErrorNotFoundPage extends HookConsumerWidget {
  const ErrorNotFoundPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: errorWidgetPage(
        context, "Gagal Mengakses Halaman",
        "Mohon coba akses beberapa saat lagi",
        // imagePath: AssetImageDrawable.errorPageNotFoundSvg
      ),
    );
  }
}
