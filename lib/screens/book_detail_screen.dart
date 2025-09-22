import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/provider/book_progress_provider.dart';
import 'package:phonics/core/provider/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:phonics/core/router/routes.dart';
import 'package:phonics/widgets/basic_lg_button_for_text.dart';
import 'package:phonics/widgets/book_detail/book_detail_card.dart';

import 'package:phonics/core/utils/api_service.dart';
import 'package:phonics/core/models/book/book_detail.dart';

class BookDetailScreen extends ConsumerStatefulWidget {
  final String bookId;
  const BookDetailScreen({super.key, required this.bookId});

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  late Future<BookDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _loadDetail(widget.bookId);
  }

  Future<BookDetail> _loadDetail(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('access_token');
    return ApiService.fetchBookDetail(id: bookId, jwt: jwt);
  }

  String _coverImageForAge(String ageGroup) {
    switch (ageGroup) {
      case '1세 이하':
        return 'https://github.com/Sookmyung-Graduation-Project/bookcoverdata/blob/main/Level%201.png?raw=true';
      case '1~2세':
        return 'https://github.com/Sookmyung-Graduation-Project/bookcoverdata/blob/main/Level%202.png?raw=true';
      case '3~4세':
        return 'https://github.com/Sookmyung-Graduation-Project/bookcoverdata/blob/main/Level%203.png?raw=true';
      case '5~6세':
        return 'https://github.com/Sookmyung-Graduation-Project/bookcoverdata/blob/main/Level%204.png?raw=true';
      case '7~8세':
        return 'https://github.com/Sookmyung-Graduation-Project/bookcoverdata/blob/main/Level%205.png?raw=true';
      case '9~10세':
        return 'https://github.com/Sookmyung-Graduation-Project/bookcoverdata/blob/main/Level%206.png?raw=true';
      default:
        return 'https://indigenousreadsrisingcom.b-cdn.net/wp-content/uploads/2023/10/1.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(serverUserProvider);
    final userId = userInfo?.id ?? 'guest';

    final progressAsync = ref.watch(
      bookProgressProvider((userId: userId, bookId: widget.bookId)),
    );
    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: FutureBuilder<BookDetail>(
        future: _detailFuture,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('에러: ${snap.error}'));
          }
          final detail = snap.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                BookDetailCard(
                  title: detail.title,
                  imageUrl: _coverImageForAge(detail.ageGroup),
                  coin: 0,
                  rating: 0.0,
                  age: detail.ageGroup,
                  pages: '${detail.pageCount} 페이지',
                  duration: '${detail.pageCount}분',
                  summary: detail.summary,
                ),

                // 진행률 표시 (Riverpod)
                progressAsync.when(
                  data: (progress) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          color: Colors.amber[400],
                          minHeight: 6,
                        ),
                        const SizedBox(height: 6),
                        Text('${(progress * 100).toStringAsFixed(0)}% 읽음'),
                      ],
                    ),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, _) => Text('에러: $e'),
                ),
                // 읽으러 가기 버튼
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BasicLgButtonForText(
                    title: '책 읽으러 가기',
                    onPressed: () async {
                      await context.push(
                        '${Routes.homeTab}/${Routes.bookDetail}/${Routes.bookContent}',
                        extra: detail,
                      );
                      ref.invalidate(bookProgressProvider(
                          (userId: userId, bookId: widget.bookId)));
                      ref.invalidate(progressMapProvider(userId));
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
