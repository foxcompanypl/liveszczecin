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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        child: ListView.builder(
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
                  Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.black,
                      child: Opacity(
                        opacity: 0.5,
                        child: CachedNetworkImage(
                          cacheKey:
                              "${items[index].id}_${DateFormat("yyyyMMddHH").format(DateTime.now())}",
                          imageUrl: items[index].image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(20),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: refresh,
        icon: const Icon(Icons.refresh),
        label: const Text('Odśwież'),
      ),
    );
  }
}
