import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:phonics/core/router/routes.dart';
import 'package:phonics/widgets/basic_lg_button_for_text.dart';
import 'package:phonics/widgets/book_detail/book_detail_card.dart';

import 'package:phonics/core/utils/api_service.dart';
import 'package:phonics/core/models/book/book_detail.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId;

  const BookDetailScreen({super.key, required this.bookId});

  Future<BookDetail> _loadDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('access_token');
    return ApiService.fetchBookDetail(id: bookId, jwt: jwt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: FutureBuilder<BookDetail>(
        future: _loadDetail(),
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
                  imageUrl:
                      'https://img1.daumcdn.net/thumb/R1280x0.fwebp/?fname=http://t1.daumcdn.net/brunch/service/user/9vB/image/MHFCeUJi2rRSfw__IfgBZgoNo3E',
                  coin: 0,
                  rating: 0.0,
                  age: detail.ageGroup,
                  pages: '${detail.pageCount} 페이지',
                  duration: '${detail.pageCount}분',
                  summary: detail.summary,
                ),
                _GoToBookButton(detail: detail),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GoToBookButton extends StatelessWidget {
  final BookDetail detail;
  const _GoToBookButton({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BasicLgButtonForText(
        onPressed: () {
          context.go(
            '${Routes.homeTab}/${Routes.bookDetail}/${Routes.bookContent}',
            extra: detail,
          );
        },
        title: '책 읽으러 가기',
      ),
    );
  }
}
