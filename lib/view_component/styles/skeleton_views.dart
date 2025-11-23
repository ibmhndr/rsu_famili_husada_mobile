//======SHIMMER DIALOG======
//Shimmer Card Widget
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cardSkeletonSlideshow(BuildContext context, double circular) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: const Color(0xffC0C0C0),
      highlightColor: const Color(0xffDCDCDC),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circular), color: Colors.grey),
        padding: const EdgeInsets.all(16),
      ));
}

Widget cardSkeletonCircle(BuildContext context) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        padding: const EdgeInsets.all(8),
      ));
}

Widget cardSkeletonRectangleRadius(BuildContext context, double circular) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circular), color: Colors.grey),
        padding: const EdgeInsets.all(8),
      ));
}

Widget cardSkeletonText(
    BuildContext context, double sizeString, double length, double radius) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        // margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text Title
                Flexible(
                  child: Container(
                    height: sizeString,
                    width: length,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget cardSkeletonProductContentGrid(BuildContext context, double imgHeight) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Column
            Container(
              height: imgHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.022),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text Title
                Flexible(
                  child: Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text Title
                Flexible(
                  child: Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text Title
                Flexible(
                  child: Container(
                    height: 13,
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget cardSkeletonSellerContentGrid(BuildContext context, double imgHeight) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 2),
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Column
            Container(
              height: imgHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.grey),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.022),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text Title
                Flexible(
                  child: Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.35,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text Title
                Flexible(
                  child: Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
