import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phonics/core/provider/voice_provider.dart';
import 'package:phonics/core/models/user/user_voice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:phonics/core/utils/test_voice_service.dart';
import 'package:phonics/widgets/show_rename_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:phonics/core/provider/loading_provider.dart';

class MypageToVoicesetting extends ConsumerWidget {
  const MypageToVoicesetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(
        title: const Text('음성세팅'),
        backgroundColor: const Color(0xffFFFFEB),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  DefaultVoiceSection(),
                  SizedBox(height: 20),
                  CustomVoiceSection(),
                  SizedBox(height: 20),
                  AddVoiceButton(),
                ],
              ),
            ),
          ),
          if (isLoading) ...[
            Positioned.fill(
              child: IgnorePointer(
                ignoring: false,
                child: Container(
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
            ),
            const Center(
              child: SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DefaultVoiceSection extends ConsumerWidget {
  const DefaultVoiceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voices = ref.watch(voicesProvider);

    final defaultVoice = voices.firstWhere(
      (v) => v.defaultId == true,
      orElse: () => VoiceItem(
        id: '',
        voiceName: '기본 음성이 없습니다.',
        voiceId: '',
        description: null,
        createdAt: null,
        defaultId: false,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
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
    final loading = ref.watch(voicesLoadingProvider);

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
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
        voices.isEmpty
            ? Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: const Color(0xffA5A5A5), width: 0.2),
                ),
                child: const Text(
                  '등록된 커스텀 음성이 없습니다.',
                  style: TextStyle(
                    fontFamily: 'GyeonggiTitleLight',
                    fontSize: 14,
                    color: Color(0xff525152),
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                children: voices
                    .map((v) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: VoiceTile(
                            item: v,
                            isDefault: v.voiceId == defaultId,
                          ),
                        ))
                    .toList(),
              ),
      ],
    );
  }
}

class VoiceTile extends ConsumerWidget {
  VoiceTile({super.key, required this.item, required this.isDefault});

  final VoiceItem item;
  final bool isDefault;

  final List<String> menu = ['음성 이름 변경', '기본 음성으로 변경', '음성 테스트', '음성 삭제'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createdText = item.createdAt != null
        ? DateFormat('yyyy.MM.dd HH:mm').format(item.createdAt!)
        : '-';

    final loading = ref.watch(loadingProvider);

    return GestureDetector(
      onTap: () {},
      child: Opacity(
        opacity: loading ? 0.6 : 1.0,
        child: AbsorbPointer(
          absorbing: loading,
          child: Container(
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
                DropdownButton<String>(
                  icon: const Icon(Icons.more_vert),
                  underline: const SizedBox(),
                  dropdownColor: Colors.white,
                  onChanged: loading
                      ? null
                      : (value) async {
                          final setLoading = ref.read(loadingProvider.notifier);
                          if (value == '기본 음성으로 변경') {
                            final prefs = await SharedPreferences.getInstance();
                            final jwt = prefs.getString('access_token');
                            if (jwt == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('로그인 정보가 없습니다.')),
                              );
                              return;
                            }
                            try {
                              setLoading.state = true;
                              final res = await ApiService.updateDefaultVoice(
                                jwt: jwt,
                                voiceId: item.voiceId,
                              );
                              if (res['ok'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('기본 음성으로 변경되었습니다.')),
                                );
                                await ref
                                    .read(voicesProvider.notifier)
                                    .fetchVoices(jwt);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '변경 실패: ${res['error'] ?? '알 수 없는 오류'}',
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('오류 발생: $e')),
                              );
                            } finally {
                              setLoading.state = false;
                            }
                          } else if (value == '음성 이름 변경') {
                            final newName =
                                await showRenameVoiceDialog(context);
                            if (newName != null && newName.isNotEmpty) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final jwt = prefs.getString('access_token');
                              if (jwt == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('로그인 정보가 없습니다.')),
                                );
                                return;
                              }
                              try {
                                setLoading.state = true;
                                final res = await ApiService.renameVoice(
                                  jwt: jwt,
                                  voiceId: item.voiceId,
                                  newName: newName,
                                );
                                if (res != null && res['ok'] == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('음성 이름이 변경되었습니다.')),
                                  );
                                  await ref
                                      .read(voicesProvider.notifier)
                                      .fetchVoices(jwt);
                                } else {
                                  final errorMsg = (res != null)
                                      ? res['error'] ?? '알 수 없는 오류'
                                      : '응답 형식 오류';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('변경 실패: $errorMsg')),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('오류 발생: $e')),
                                );
                              } finally {
                                setLoading.state = false;
                              }
                            }
                          } else if (value == '음성 삭제') {
                            final prefs = await SharedPreferences.getInstance();
                            final jwt = prefs.getString('access_token');
                            if (jwt == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('로그인 정보가 없습니다.')),
                              );
                              return;
                            }
                            try {
                              setLoading.state = true;
                              final res = await ApiService.deleteVoice(
                                jwt: jwt,
                                voiceId: item.voiceId,
                              );
                              if (res != null && res['ok'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('음성이 삭제되었습니다.')),
                                );
                                await ref
                                    .read(voicesProvider.notifier)
                                    .fetchVoices(jwt);
                              } else {
                                final errorMsg = (res != null)
                                    ? res['error'] ?? '알 수 없는 오류'
                                    : '응답 형식 오류';
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('삭제 실패: $errorMsg')),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('오류 발생: $e')),
                              );
                            } finally {
                              setLoading.state = false;
                            }
                          } else if (value == '음성 테스트') {
                            final prefs = await SharedPreferences.getInstance();
                            final jwt = prefs.getString('access_token');
                            if (jwt == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('로그인 정보가 없습니다.')),
                              );
                              return;
                            }
                            try {
                              setLoading.state = true;
                              final audioData = await ApiService.testTTSVoice(
                                jwt: jwt,
                                voiceId: item.voiceId,
                                text: '테스트 음성입니다.',
                              );
                              if (audioData != null) {
                                final testVoiceService = TestVoiceService();
                                final filePath = await testVoiceService
                                    .saveAudioToFile(audioData);
                                if (filePath != null) {
                                  await testVoiceService
                                      .playAudioFromFile(filePath);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('음성 테스트 완료!')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('음성 파일 저장 실패')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('음성 데이터가 없습니다')),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('오류 발생: $e')),
                              );
                            } finally {
                              setLoading.state = false;
                            }
                          }
                        },
                  items: menu
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddVoiceButton extends ConsumerWidget {
  const AddVoiceButton({super.key});

  Future<Duration?> _getAudioDuration(String path) async {
    final player = AudioPlayer();
    try {
      return await player.setFilePath(path);
    } catch (e) {
      debugPrint('duration 측정 실패: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    final setLoading = ref.read(loadingProvider.notifier);

    return GestureDetector(
      onTap: isLoading
          ? null
          : () async {
              try {
                final picked = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'flac'],
                  allowMultiple: false,
                  withData: false,
                );
                if (picked == null) return;

                setLoading.state = true;

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
                      content: Text('1분 이하 파일만 업로드 가능해요. (${dur.inSeconds}초)'),
                    ),
                  );
                  return;
                }

                final prefs = await SharedPreferences.getInstance();
                final jwt = prefs.getString('access_token');
                if (jwt == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('로그인 정보가 없습니다.')),
                  );
                  return;
                }

                await ApiService.uploadIvc(
                  jwt: jwt,
                  name: '새 음성',
                  description: null,
                  files: [path],
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('파일 추가 완료! (1분 이하)')),
                );

                await ref.read(voicesProvider.notifier).fetchVoices(jwt);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('파일 선택/업로드 실패: $e')),
                );
              } finally {
                setLoading.state = false;
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
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
