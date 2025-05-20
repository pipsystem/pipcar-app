import '../di/di.dart';

class AppInitializer {
  static Future<void> init() async {
    configureDependencies();
  }
}
