import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/camera_model.dart';

class CameraService {
  static final CameraService _instance = CameraService._internal();
  final List<String> _urls = [
    "https://lantech.com.pl/liveszczecinapp/list.json",
    "http://lantech.com.pl/liveszczecinapp/list.json",
    "https://foxcompany.pl/liveszczecin/list.json",
  ];

  factory CameraService() => _instance;

  CameraService._internal();

  Future<List<CameraModel>> getAll() async {
    for (var url in _urls) {
      try {
        var response = await http.get(Uri.parse(url));
        debugPrint("Url $url, status: ${response.statusCode}");
        if (response.statusCode != HttpStatus.ok) {
          continue;
        }
        List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
        return _filterResults(
            json.map((json) => CameraModel.fromJson(json)).toList());
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return [];
  }

  List<CameraModel> _filterResults(List<CameraModel> results) {
    return results.map((e) {
      return e.CopyWith(
          url: e.url.replaceFirst(RegExp("^https://"), "http://"));
    }).toList();
  }
}
