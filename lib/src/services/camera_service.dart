import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/camera_model.dart';

class CameraService {
  static const String url = "https://foxcompany.pl/liveszczecin/list.json";
  static bool _loaded = false;
  static List<CameraModel> _list = [];

  static Future load({bool refresh = true}) async {
    if (_loaded == true && refresh == false) {
      return;
    }
    var response = await http.get(Uri.parse(url));
    List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    _list = json.map((json) => CameraModel.fromJson(json)).toList();
    _loaded = true;
  }

  static Future<List<CameraModel>> getAll({bool refresh = true}) async {
    await load(refresh: refresh);
    return _list;
  }

  static Future<CameraModel> get(int id) async {
    await load();
    return _list.firstWhere((element) => element.id == id);
  }
}
