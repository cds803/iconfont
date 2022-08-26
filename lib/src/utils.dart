import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:path/path.dart' as path;

import 'package:http/http.dart' as http;
import 'dart:io';

/// Utils
class Utils {
  /// 格式化
  static formatName(String str) {
    return str
        .split("_")
        .map((e) => e.isNotEmpty ? capitalize(e) : "")
        .join("")
        .replaceAll('-', '_')
        .split("_")
        .map((e) => e.isNotEmpty ? capitalize(e) : "")
        .join("_");
  }

  /// 首字母大写
  static String capitalize(String str) {
    return "${str[0].toUpperCase()}${str.substring(1)}";
  }

  // 创建文件夹
  static createDir(String p) {
    var dir = Directory(p);
    if (!dir.existsSync()) dir.createSync(recursive: true);
  }

  // 写入文件
  static writeToFile(String filePath, {String? contents, Uint8List? bytes}) {
    createDir(path.dirname(filePath));

    if (contents != null) {
      File(filePath).writeAsStringSync(contents);
    }

    if (bytes != null) {
      File(filePath).writeAsBytesSync(bytes);
    }
  }

  // http get
  static Future<Response?> httpGet(String url) async {
    Uri uri = Uri.parse(url);
    uri = uri.replace(scheme: "https");

    final rsp = await http.get(uri);
    if (rsp.statusCode != 200) {
      print("${uri.toString()} 请求失败 , statusCode = ${rsp.statusCode}");
      return null;
    }

    return rsp;
  }

  // 下载到文件
  static Future<void> downloadToFile(String filePath, String url) async {
    final response = await httpGet(url);
    if (response == null) return;

    writeToFile(
      filePath,
      bytes: response.bodyBytes,
    );
  }
}
