import 'package:flutter_riverpod/flutter_riverpod.dart';


final isLoadingProvider = StateProvider<bool>((_) => false);

Future<T> withLoading<T>(WidgetRef ref, Future<T> Function() task) async {
  ref.read(isLoadingProvider.notifier).state = true;
  try {
    return await task();
  } finally {
    ref.read(isLoadingProvider.notifier).state = false;
  }
}

final loadingProvider = StateProvider<bool>((ref) => false);

