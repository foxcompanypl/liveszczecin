import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/camera_model.dart';

class CameraService {
  static const List<String> urls = [
    "https://lantech.com.pl/liveszczecinapp/list.json",
    "http://lantech.com.pl/liveszczecinapp/list.json",
    "https://foxcompany.pl/liveszczecin/list.json",
  ];

  static Future<List<CameraModel>> getAll() async {
    for (var url in urls) {
      var response = await http.get(Uri.parse(url));
      print("Url $url, status: ${response.statusCode}");
      if (response.statusCode != HttpStatus.ok) {
        continue;
      }
      List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      return json.map((json) => CameraModel.fromJson(json)).toList();
    }
    return [];
  }
}
