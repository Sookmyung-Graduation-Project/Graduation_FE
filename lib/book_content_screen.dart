import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phonics/core/provider/book_progress_provider.dart';

import 'package:phonics/core/provider/jwt_provider.dart';
import 'package:phonics/core/provider/user_info_provider.dart';
import 'package:phonics/core/repository/local_progress_repository.dart';
import 'package:phonics/core/utils/api_service.dart';

class BookContentScreen extends ConsumerStatefulWidget {
  final List<String> pages;
  final String bookId;

  const BookContentScreen({
    super.key,
    required this.pages,
    required this.bookId,
  });

  @override
  ConsumerState<BookContentScreen> createState() => _BookContentScreenState();
}

class _BookContentScreenState extends ConsumerState<BookContentScreen> {
  final _pageController = PageController();
  final _player = AudioPlayer();

  int _currentIndex = 0;
  int _requestSeq = 0;
  final Map<int, String> _audioCache = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _initAndPlayFirstPage();
    });
  }

  Future<void> _initAndPlayFirstPage() async {
    final jwt = ref.read(jwtProvider);
    if (jwt == null || jwt.isEmpty) {
      _showSnack('로그인이 필요합니다.');
      return;
    }
    await _speakPage(_currentIndex);
  }

  Future<void> _speakPage(int index) async {
    final jwt = ref.read(jwtProvider);
    if (jwt == null || jwt.isEmpty) return;

    final seq = ++_requestSeq;
    final text = widget.pages[index];
    if (text.trim().isEmpty) return;

    try {
      if (_audioCache.containsKey(index)) {
        if (seq != _requestSeq) return;
        await _player.stop();
        await _player.setFilePath(_audioCache[index]!);
        await _player.play();
        return;
      }

      final Uint8List? bytes = await ApiService.ttsWithDefaultVoice(
        jwt: jwt,
        text: text,
      );

      if (seq != _requestSeq) return;

      if (bytes == null) {
        _showSnack('TTS 생성 실패 (페이지 ${index + 1})');
        return;
      }

      final filePath = await _writeTempAudio(bytes, 'page_$index.mp3');
      _audioCache[index] = filePath;

      await _player.stop();
      await _player.setFilePath(filePath);
      await _player.play();
    } catch (e) {
      if (seq != _requestSeq) return;
      _showSnack('재생 실패: $e');
    }
  }

  Future<String> _writeTempAudio(Uint8List bytes, String name) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(msg)));
    });
  }

  Future<void> _updateProgress(int pageIndex) async {
    final userInfo = ref.read(serverUserProvider);
    final userId = userInfo?.id ?? "guest";

    await LocalProgressRepo.setProgress(
      userId: userId,
      bookId: widget.bookId,
      currentPage: pageIndex + 1,
      totalPages: widget.pages.length,
    );

    ref.invalidate(
      bookProgressProvider((userId: userId, bookId: widget.bookId)),
    );
    ref.invalidate(progressMapProvider(userId));
  }

  @override
  void dispose() {
    _player.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("책 읽기"),
        actions: [
          IconButton(
            tooltip: '다시 읽기',
            icon: const Icon(Icons.play_arrow),
            onPressed: () => _speakPage(_currentIndex),
          ),
          IconButton(
            tooltip: _player.playing ? '일시정지' : '재생',
            icon: Icon(_player.playing ? Icons.pause : Icons.volume_up),
            onPressed: () async {
              if (_player.playing) {
                await _player.pause();
              } else {
                await _player.play();
              }
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.pages.length,
        onPageChanged: (i) {
          _currentIndex = i;
          _speakPage(i);
          _updateProgress(i);
        },
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(
              widget.pages[index],
              style: const TextStyle(fontSize: 20, height: 1.6),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
