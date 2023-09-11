import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
//
import '../models/camera_model.dart';
import '../services/camera_service.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<CameraModel> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  void refresh() {
    _refreshIndicatorKey.currentState?.show();
  }

  Future<void> _loadData() async {
    var items = await CameraService.getAll();
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    int columns = MediaQuery.of(context).size.width > 600 ? 2 : 1;
    double aspectRatio = MediaQuery.of(context).size.width > 600 ? 1.5 : 2;
    return Scaffold(
        appBar: AppBar(
          title: const Text("LiveSzczecin"),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _loadData,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: aspectRatio,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/camera',
                      arguments: items[index]);
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        cacheKey:
                            "${items[index].id}_${DateFormat("yyyyMMddHH").format(DateTime.now())}",
                        imageUrl: items[index].image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 50,
                            color: Colors.red),
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.7),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Text(
                        items[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
