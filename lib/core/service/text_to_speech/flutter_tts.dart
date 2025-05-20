import 'package:flutter_tts/flutter_tts.dart';

class FlutterTtsService {
  static final FlutterTtsService _FlutterTtsService = FlutterTtsService._internal();

  factory FlutterTtsService() {
    return _FlutterTtsService;
  }

  FlutterTtsService._internal();

  static FlutterTts flutterTts = FlutterTts();

  static void init() async {
    await flutterTts.setLanguage('vi-VN');
    await flutterTts.setPitch(1);
  }

  static void speak(String text) {
    flutterTts.speak(text);
  }
}
