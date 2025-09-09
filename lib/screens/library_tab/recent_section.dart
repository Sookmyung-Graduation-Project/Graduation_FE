import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/models/book/book_mock.dart';
import 'package:phonics/core/router/routes.dart';

class RecentSection extends ConsumerWidget {
  const RecentSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 20, bottom: 16, right: 14, left: 14),
      itemCount: mockBooks.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 24, color: Colors.grey),
      itemBuilder: (context, index) {
        final book = mockBooks[index];
        return InkWell(
          onTap: () {
            context.go(
              '${Routes.homeTab}/${Routes.bookDetail}',
              extra: book,
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  book['image']!,
                  width: MediaQuery.of(context).size.width * 0.18,
                  height:
                      MediaQuery.of(context).size.width * 0.18 * (94 / 67.4),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Genre : ${book['genre']}'),
                    Text('Point : ${book['point']} 🪙'),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.blue, size: 18),
                        // rating 텍스트는 생략
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: book['progress'] as double,
                      backgroundColor: Colors.grey[200],
                      color: Colors.amber[400],
                      minHeight: 6,
                    ),
                    Text('${((book['progress'] as double) * 100).toInt()}%'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
