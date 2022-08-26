import 'dart:convert';

import 'package:iconfont/src/utils.dart';

import 'constants.dart';

import 'iconfont_data.dart';

import 'package:path/path.dart' as path;

class IconFontCss {
  final String cssUrl;
  final String dirPath;
  final String? fontPackage;
  const IconFontCss({
    required this.cssUrl,
    required this.dirPath,
    this.fontPackage,
  });

  downloadFromCss() async {
    if (cssUrl.isEmpty) return;

    final response = await Utils.httpGet(cssUrl);

    if (response == null) return;

    final data = IconFontData.parse(response.body);
    data.fontPackage = fontPackage;
    Utils.writeToFile(
      path.joinAll([dirPath, Constants.ICONFONT_FILE_JSON]),
      contents: jsonEncode(data),
    );

    Utils.writeToFile(
      path.joinAll([dirPath, Constants.ICONFONT_FILE_TEXT]),
      contents: data.tffPath!,
    );

    await Utils.downloadToFile(
      path.joinAll([dirPath, Constants.ICONFONT_FILE_TTF]),
      data.tffPath!,
    );
  }
}
