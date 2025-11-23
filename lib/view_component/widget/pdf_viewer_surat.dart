import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rsufamilyhusadacare_mobile/repository/other/file_manipulation.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class PDFSuratViewer extends ConsumerStatefulWidget {
  //@Share File Function
  final String filenameFull;
  final Uint8List file;
  final String judul;
  final String? urlWeb;
  bool? isShowDownload = true;

  PDFSuratViewer({
    Key? key,
    required this.filenameFull,
    required this.file,
    required this.judul,
    this.urlWeb,
    this.isShowDownload,
  }) : super(key: key);

  @override
  ConsumerState createState() => PDFSuratViewerState();
}

class PDFSuratViewerState extends ConsumerState<PDFSuratViewer> {
  PdfControllerPinch? pdfViewController;
  int pages = 0;
  int indexPage = 1;
  bool isLoading = false;

  Map<String, dynamic> revisorSuratArgs = {'srt_id': ''};

  @override
  void initState() {
    super.initState();
    pdfViewController = PdfControllerPinch(
      document: PdfDocument.openData(widget.file),
    );
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    super.dispose();
    if (pdfViewController != null) {
      if (kDebugMode) {
        print('Dispose Controller');
      }
      pdfViewController?.dispose();
    }
    WakelockPlus.disable();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kDebugMode) {
        print('Pages : $pages, Index : $indexPage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    final text = '$indexPage dari $pages';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        actions: (pages > 1)
            ? [
                Center(
                  child: AutoSizeText(
                    text,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                //@Min Button
                IconButton(
                    onPressed: () {
                      final page = (indexPage == 1) ? 1 : indexPage - 1;
                      pdfViewController!.animateToPage(
                          pageNumber: page,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease);

                      if (kDebugMode) {
                        print('Navigate to Page : $page');
                      }
                    },
                    icon: const Icon(Icons.chevron_left)),
                //@Plus Button
                IconButton(
                    onPressed: () {
                      final page = (indexPage == pages) ? pages : indexPage + 1;
                      pdfViewController!.animateToPage(
                          pageNumber: page,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease);

                      if (kDebugMode) {
                        print('Navigate to Page : $page');
                      }
                    },
                    icon: const Icon(Icons.chevron_right))
              ]
            : null,
        title: AutoSizeText(
          widget.filenameFull,
          minFontSize: 14,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      //@Download Button
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: (widget.isShowDownload ?? true),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //@Download Button
                FloatingActionButton(
                  tooltip: 'Unduh Berkas',
                  heroTag: null,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () async {
                    await FileManipulation.instance.storeFileFromNetwork(
                        context, widget.file, widget.filenameFull);
                  },
                  child: const Icon(Icons.download),
                ),
                //@Spacing
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              ],
            ),
          ),

          //@Share button
          Visibility(
            visible: (widget.urlWeb ?? '').isNotEmpty,
            child: FloatingActionButton(
              tooltip: 'Bagikan Berkas',
              heroTag: null,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onPressed: () async {
                if (isLoading == false) {
                  try {
                    // File? savedFile = await FileManipulation.singleton
                    //     .storeFileFromNetwork(
                    //         context, widget.networkFile, widget.filenameFull,
                    //         isShowToast: false);

                    Share.share(
                        "Sepertinya kamu perlu melihat ini, ${widget.judul}. Selengkapnya kunjungi  ${widget.urlWeb}",
                        subject: "Coba Cek, Ada Info Menarik Untuk Kamu");
                  } on Exception catch (e) {
                    if (kDebugMode) {
                      print('Terjadi kegagalan membagikan file : $e');
                    }

                    //@Show Error Messages
                    showToast('Terjadi kegagalan dalam membagikan berkas');
                  } finally {
                    isLoading = false;
                  }
                }
              },
              child: Icon(
                Icons.share,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      body: PdfViewPinch(
        controller: pdfViewController!,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() => indexPage = index);
        },
        onDocumentLoaded: (PdfDocument document) {
          setState(() {
            pages = document.pagesCount;
          });
        },
        onDocumentError: (object) {
          showToast('Terjadi kegagalan dalam memuat dokumen');
        },
        // onRender: (pages) => setState( ()=> this.pages = pages!),
        // onViewCreated: (controller) {
        //   setState(() => this.pdfViewController = controller);
        // },
        // swipeHorizontal: true,
        // pageSnap: false,
        // filePath: widget.file.path,
      ),
    );
  }
}
