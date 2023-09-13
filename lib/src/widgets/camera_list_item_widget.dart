import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
//
import 'package:liveszczecin/src/models/camera_model.dart';

class CameraListItemWidget extends StatefulWidget {
  final CameraModel item;
  const CameraListItemWidget({super.key, required this.item});

  @override
  State<CameraListItemWidget> createState() => _CameraListItemWidgetState();
}

class _CameraListItemWidgetState extends State<CameraListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Skeleton.replace(
                child: CachedNetworkImage(
              cacheKey:
                  "${widget.item.id}_${DateFormat("yyyyMMddHH").format(DateTime.now())}",
              imageUrl: widget.item.image,
              fadeOutDuration: const Duration(milliseconds: 200),
              fadeInDuration: const Duration(milliseconds: 200),
              placeholderFadeInDuration: const Duration(milliseconds: 0),
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 50, color: Colors.red),
            ))),
        Container(
          color: Colors.black.withOpacity(0.7),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Text(
            widget.item.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
