import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/models/user/user_voice.dart';
import 'package:phonics/core/utils/api_service.dart';

class VoicesNotifier extends StateNotifier<List<VoiceItem>> {
  VoicesNotifier(this.ref) : super([]);

  final Ref ref;

  Future<void> fetchVoices(String jwt) async {
    ref.read(voicesLoadingProvider.notifier).state = true;

    try {
      final items = await ApiService.fetchMyVoices(jwt: jwt);
      if (items != null) {
        state = items.map((e) => VoiceItem.fromJson(e)).toList();
      }
    } finally {
      ref.read(voicesLoadingProvider.notifier).state = false;
    }
  }
}

final voicesProvider = StateNotifierProvider<VoicesNotifier, List<VoiceItem>>(
  (ref) => VoicesNotifier(ref),
);

final defaultVoiceIdProvider = StateProvider<String?>((ref) => null);
final voicesLoadingProvider = StateProvider<bool>((ref) => false);
