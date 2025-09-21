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
                  imageUrl: _coverImageForAge(detail.ageGroup),
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
