import 'package:flutter/material.dart';
//
import 'package:liveszczecin/src/models/camera_model.dart';
import 'package:liveszczecin/src/widgets/camera_list_item_widget.dart';

class CameraListWidget extends StatefulWidget {
  final List<CameraModel> items;
  const CameraListWidget({super.key, required this.items});

  @override
  State<CameraListWidget> createState() => _CameraListWidgetState();
}

class _CameraListWidgetState extends State<CameraListWidget> {
  @override
  Widget build(BuildContext context) {
    int columns = MediaQuery.of(context).size.width > 600 ? 2 : 1;
    double aspectRatio = MediaQuery.of(context).size.width > 600 ? 1.5 : 2;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/camera',
                arguments: widget.items[index]);
          },
          child: CameraListItemWidget(item: widget.items[index]),
        );
      },
    );
  }
}
