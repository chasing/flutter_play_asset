// ignore_for_file: non_constant_identifier_names

import 'package:flutter/services.dart';

class FlutterPlayAsset {
  final String METHOD_PLAYASSET = "playasset";
  final String METHOD_DOWNLOAD_PROGRESS_UPDATE = "playasset_download_pprogress_update";
  final String METHOD_GETASSET = "get_asset";
  static const platform = MethodChannel('basictomodular/downloadservice');
  late ViewPlayAsset view;

  init(ViewPlayAsset vw) {
    print("JOSHX Hello, world. Again.");
    view = vw;
    platform.setMethodCallHandler((call) {
      print('platform channel method call ${call.method} ${call.arguments}');
      if (call.method == METHOD_PLAYASSET) {
        if (!call.arguments.toString().contains("...")) {
          view.OnAssetPathFound(call.arguments.toString());
        } else {
          view.OnProcessLoadingAssetPath(call.arguments.toString());
        }
      } else if (call.method == METHOD_DOWNLOAD_PROGRESS_UPDATE) {
        view.OnProgressDownload(call.arguments);
      }
      throw '';
    });
  }

  getAssetPath(String name) async {
    await platform.invokeMethod<String>(METHOD_GETASSET, name);
  }
}

class ViewPlayAsset {
  void OnProgressDownload(int percentage) {}

  void OnAssetPathFound(String path) {}

  void OnProcessLoadingAssetPath(String path) {}
}
