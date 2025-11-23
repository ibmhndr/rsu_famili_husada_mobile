import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';

//ERROR Looking up a deactivated widget's ancestor is unsafe. Ketika tidak dizoom
class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper(
      {Key? key,
      this.loadingBuilder,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex = 0,
      required this.galleryItems,
      this.scrollDirection = Axis.horizontal,
      required this.heroTag})
      : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final Image galleryItems;
  final Axis scrollDirection;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            //@Loading widget
            showLoadingWidget(
              context,
              colorAccentWhite(),
            ),

            //@Galery Builder
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (_, index) => _buildItem(index),
              itemCount: 1,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            // Container(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text(
            //     "Image ${currentIndex + 1}",
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 17.0,
            //       decoration: null,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(int index) {
    final item = widget.galleryItems;
    return PhotoViewGalleryPageOptions(
      imageProvider: item.image,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 4.0,
      heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag),
    );
  }
}
