import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phonics/core/utils/api_service.dart';

class TestVoiceService {
  Future<String?> saveAudioToFile(Uint8List audioBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp_tts_audio.mp3');
      await file.writeAsBytes(audioBytes, flush: true);
      return file.path;
    } catch (e) {
      print('오디오 임시파일 저장 실패: $e');
      return null;
    }
  }

  final player = AudioPlayer();

  Future<void> playAudioFromFile(String filePath) async {
    try {
      await player.setFilePath(filePath);
      player.play();
    } catch (e) {
      print('오디오 재생 실패: $e');
    }
  }

  Future<void> performTTSTestAndPlay(
      String jwt, String voiceId, String text) async {
    final audioData =
        await ApiService.testTTSVoice(jwt: jwt, voiceId: voiceId, text: text);
    if (audioData == null) {
      print('TTS 오디오 데이터 없음');
      return;
    }

    final path = await saveAudioToFile(audioData);
    if (path == null) {
      print('오디오 파일 저장 실패');
      return;
    }

    await playAudioFromFile(path);
  }
}
