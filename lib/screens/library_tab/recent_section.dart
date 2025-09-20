import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/models/book/book.dart';
import 'package:phonics/core/models/book/book_mock.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSection extends ConsumerWidget {
  const RecentSection({super.key});

  Future<List<BookItem>> _loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('access_token'); // 없으면 null
    final books = await ApiService.fetchMyBooks(jwt: jwt);

    return books;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<BookItem>>(
      future: _loadBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('에러: ${snapshot.error}'));
        }
        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return const Center(child: Text('책이 없습니다.'));
        }

        return ListView.separated(
          padding:
              const EdgeInsets.only(top: 20, bottom: 16, right: 14, left: 14),
          itemCount: books.length,
          separatorBuilder: (_, __) =>
              const Divider(height: 24, color: Colors.grey),
          itemBuilder: (context, index) {
            final book = books[index];
            return InkWell(
              onTap: () {
                context.go(
                  '${Routes.homeTab}/${Routes.bookDetail}',
                  extra: book.id,
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.width *
                          0.18 *
                          (94 / 67.4),
                      color: Colors.grey[300],
                      child: const Icon(Icons.book,
                          size: 40, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('교훈: ${book.lesson}'),
                        Text('주인공: ${book.animal}'),
                        Text('연령대: ${book.ageGroup}'),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.0, // 읽은 진행도: 추후 서버 값 있으면 매핑
                          backgroundColor: Colors.grey[200],
                          color: Colors.amber[400],
                          minHeight: 6,
                        ),
                        const Text("0%"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
