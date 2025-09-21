import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/models/book/book.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:phonics/core/provider/book_progress_provider.dart';
import 'package:phonics/core/provider/user_info_provider.dart';

class RecentSection extends ConsumerWidget {
  const RecentSection({super.key});

  Future<List<BookItem>> _loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('access_token');
    final books = await ApiService.fetchMyBooks(jwt: jwt);
    return books;
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
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(serverUserProvider)?.id ?? "guest";

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
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _coverImageForAge(book.ageGroup),
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.width *
                          0.18 *
                          (94 / 67.4),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.book,
                            size: 40, color: Colors.black54),
                      ),
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
                        Consumer(
                          builder: (context, ref, _) {
                            final progressAsync = ref.watch(
                              bookProgressProvider(
                                (userId: userId, bookId: book.id),
                              ),
                            );

                            return progressAsync.when(
                              data: (progress) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.grey[200],
                                      color: Colors.amber[400],
                                      minHeight: 6,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                        '${(progress * 100).toStringAsFixed(0)}% 읽음'),
                                  ],
                                );
                              },
                              loading: () => const LinearProgressIndicator(),
                              error: (err, _) => Text("진행률 불러오기 실패: $err"),
                            );
                          },
                        ),
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
