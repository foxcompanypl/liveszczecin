import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
      try {
        var response = await http.get(Uri.parse(url));
        debugPrint("Url $url, status: ${response.statusCode}");
        if (response.statusCode != HttpStatus.ok) {
          continue;
        }
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        return filterResults(
            json.map((json) => CameraModel.fromJson(json)).toList());
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return [];
  }

  static List<CameraModel> filterResults(List<CameraModel> results) {
    return results.map((e) {
      return e.CopyWith(
          url: e.url.replaceFirst(RegExp("^https://"), "http://"));
    }).toList();
  }
}
