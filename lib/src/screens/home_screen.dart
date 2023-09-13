import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:liveszczecin/src/widgets/camera_list_widget.dart';
//
import 'package:liveszczecin/src/globals.dart';
import 'package:liveszczecin/src/models/camera_model.dart';
import 'package:liveszczecin/src/services/camera_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<CameraModel> items = [];

  @override
  void initState() {
    super.initState();
    checkForUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  void refresh() {
    _refreshIndicatorKey.currentState?.show();
  }

  Future<void> _loadData() async {
    var items = await CameraService().getAll();
    setState(() {
      this.items = items;
    });
  }

  Future<bool> performUpdate({bool flexible = false}) async {
    try {
      if (flexible) {
        if (await InAppUpdate.startFlexibleUpdate() ==
            AppUpdateResult.success) {
          showSnack("Instalowanie aktualizacji...");
          await InAppUpdate.completeFlexibleUpdate();
          return true;
        }
      } else {
        return await InAppUpdate.performImmediateUpdate() ==
            AppUpdateResult.success;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  Future<void> checkForUpdate() async {
    try {
      var info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        showSnack("Dostępna jest nowa wersja aplikacji.");
        await performUpdate(flexible: info.flexibleUpdateAllowed);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: CameraListWidget(items: items),
        ));
  }
}
