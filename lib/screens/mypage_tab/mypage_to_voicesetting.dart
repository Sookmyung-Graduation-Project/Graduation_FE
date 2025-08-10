import 'package:flutter/material.dart';
import '../../widgets/mypage_audio_card.dart'; // AudioCard(title: , date: ) 구조로 되어 있어야 함
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_session/audio_session.dart';

class MypageToVoicesetting extends StatefulWidget {
  const MypageToVoicesetting({super.key});

  @override
  State<MypageToVoicesetting> createState() => _MypageToVoicesettingState();
}

class _MypageToVoicesettingState extends State<MypageToVoicesetting> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;

  bool _isRecording = false;
  String? _filePath;

  List<Map<String, String>> recordings = [
    {"title": "새로운 음성 녹음", "date": "2025.05.05"},
    {"title": "영어 단어 테스트", "date": "2025.05.03"},
  ];

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _player.openPlayer();

    AudioSession.instance.then((session) {
      session.configure(AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth |
                AVAudioSessionCategoryOptions.defaultToSpeaker,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ));
    });
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
    setState(() {
      _isRecording = true;
      _filePath = path;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();

    setState(() {
      _isRecording = false;
    });

    // 녹음 완료 시 날짜 기록
    final now = DateTime.now();
    final formattedDate =
        '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';

    setState(() {
      recordings.add({
        "title": "새로운 녹음 ${recordings.length + 1}",
        "date": formattedDate,
      });
    });

    // 자동 재생 시작
    if (_filePath != null) {
      await _player.startPlayer(
        fromURI: _filePath!,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
      setState(() {
        _isPlaying = true;
      });
    }

    if (context.mounted) {
      Navigator.of(context).pop(); // 바텀시트 닫기
    }
  }

  void _showRecordingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 내용이 많을 경우 스크롤
      backgroundColor: Colors.transparent, // 테두리 둥글게 보이게 하려면 transparent
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 빨간 안내창
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Color(0xffEB4147),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // 수직 정렬 중앙
                  children: const [
                    Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        '최대 2분까지 녹음할 수 있습니다.',
                        textAlign: TextAlign.center, // 텍스트 가운데 정렬
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'GyeonggiTitleLight',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 마이크 버튼
              GestureDetector(
                onTap: () {
                  _isRecording ? _stopRecording() : _startRecording();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xffFAC632), width: 3),
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    size: 60,
                    color: const Color(0xffFAC632),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                '버튼을 눌러 녹음을 시작하세요.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'GyeonggiTitleLight',
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: const Text(
          '음성세팅',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'GyeonggiTitleBold',
            color: Color(0xFF000000),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '기존 음성 데이터',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GyeonggiTitleLight',
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recordings.length,
                itemBuilder: (context, index) {
                  final item = recordings[index];
                  return Dismissible(
                    key: Key(item['title']! + item['date']!),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9EBED),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(
                        () {
                          recordings.removeAt(index);
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item['title']}이(가) 삭제되었습니다')),
                      );
                    },
                    child: AudioCard(
                      title: item['title']!,
                      date: item['date']!,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity, // 부모 너비만큼
              child: ElevatedButton(
                onPressed: () => _showRecordingBottomSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFAC632),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5), // 버튼 높이 조정 (옵션)
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
