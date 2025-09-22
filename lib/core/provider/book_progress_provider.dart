import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/repository/local_progress_repository.dart';

final progressMapProvider =
    FutureProvider.family<Map<String, double>, String>((ref, userId) {
  return LocalProgressRepo.getAllPercents(userId);
});

final bookProgressProvider =
    FutureProvider.family<double, ({String userId, String bookId})>(
        (ref, args) {
  return LocalProgressRepo.getPercent(userId: args.userId, bookId: args.bookId);
});
