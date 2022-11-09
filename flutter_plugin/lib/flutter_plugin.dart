import 'flutter_plugin_platform_interface.dart';

class FlutterPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> startActivity() {
    return FlutterPluginPlatform.instance.startActivity();
  }
}
