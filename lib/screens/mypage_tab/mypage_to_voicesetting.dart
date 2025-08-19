import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/provider/voice_provider.dart';
import 'package:intl/intl.dart';
import 'package:phonics/core/user/data/user_voice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MypageToVoicesetting extends ConsumerWidget {
  const MypageToVoicesetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Color(0xffFFFFEB),
        appBar: AppBar(
          title: Text('음성세팅'),
          backgroundColor: Color(0xffFFFFEB),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultVoiceSection(),
              SizedBox(height: 20),
              CustomVoiceSection(),
              AddVoiceButton()
            ],
          ),
        ));
  }
}

class DefaultVoiceSection extends ConsumerWidget {
  const DefaultVoiceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voices = ref.watch(voicesProvider);

    // default_id가 true인 음성 찾기
    final defaultVoice = voices.firstWhere(
      (v) => v.defaultId == true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기본 음성 데이터',
          style: TextStyle(
            fontFamily: 'GyeonggiTitleLight',
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color(0xff525152),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffA5A5A5), width: 0.2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFAC632),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 20),
              Text(
                defaultVoice.voiceName,
                style: const TextStyle(
                  fontFamily: 'GyeonggiTitleLight',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff525152),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomVoiceSection extends ConsumerWidget {
  const CustomVoiceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voices = ref.watch(voicesProvider);
    final defaultId = ref.watch(defaultVoiceIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '커스텀 음성 데이터',
          style: TextStyle(
            fontFamily: 'GyeonggiTitleLight',
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color(0xff525152),
          ),
        ),
        const SizedBox(height: 8),
        if (voices.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffA5A5A5), width: 0.2),
            ),
            child: const Text('등록된 커스텀 음성이 없습니다.'),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: voices.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final v = voices[index];
              final isDefault = (defaultId != null && defaultId == v.id);
              return VoiceTile(item: v, isDefault: isDefault);
            },
          ),
      ],
    );
  }
}

class VoiceTile extends ConsumerWidget {
  const VoiceTile({super.key, required this.item, required this.isDefault});

  final VoiceItem item;
  final bool isDefault;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createdText = item.createdAt != null
        ? DateFormat('yyyy.MM.dd HH:mm').format(item.createdAt!)
        : '-';

    return Container(
      padding: const EdgeInsets.all(16),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffA5A5A5), width: 0.2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFAC632),
            ),
            child: const Icon(Icons.record_voice_over,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.voiceName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'GyeonggiTitleMedium',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle,
                          size: 16, color: Colors.green),
                    ],
                  ],
                ),
                Text(
                  createdText,
                  style: const TextStyle(
                    fontFamily: 'GyeonggiTitleMedium',
                    fontSize: 10,
                    color: Color(0xff525152),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddVoiceButton extends ConsumerWidget {
  const AddVoiceButton({super.key});

  Future<Duration?> _getAudioDuration(String path) async {
    final player = AudioPlayer();
    try {
      return await player.setFilePath(path); // 총 길이 반환
    } catch (e) {
      debugPrint('duration 측정 실패: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        try {
          final picked = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'flac'],
            allowMultiple: false,
            withData: false,
          );
          if (picked == null) return;

          final path = picked.files.single.path;
          if (path == null || !File(path).existsSync()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('파일 경로를 확인해 주세요.')),
            );
            return;
          }

          final dur = await _getAudioDuration(path);
          if (dur == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('오디오 길이를 확인할 수 없습니다.')),
            );
            return;
          }
          if (dur > const Duration(minutes: 1)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('1분 이하 파일만 업로드 가능해요. (${dur.inSeconds}초)')),
            );
            return;
          }
          final prefs = await SharedPreferences.getInstance();
          final jwt = prefs.getString('access_token');

          // JWT가 없으면 경고 메시지 표시
          if (jwt == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('로그인 정보가 없습니다.')),
            );
            return;
          }

          // 업로드 진행 (여기서는 샘플로 이름/설명 고정)
          await ApiService.uploadIvc(
              jwt: jwt, name: '새 음성', description: null, files: [path]);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('파일 추가 완료! (1분 이하)')),
          );

          // 업로드 성공 시 서버에서 목록을 다시 받아오기
          await ref.read(voicesProvider.notifier).fetchVoices(jwt);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('파일 선택/업로드 실패: $e')),
          );
        }
      },
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffFAC632),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffA5A5A5), width: 0.2),
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
