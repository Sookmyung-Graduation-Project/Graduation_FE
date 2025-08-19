import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/user/data/user_voice.dart';
import 'package:phonics/core/utils/api_service.dart';

class VoicesNotifier extends StateNotifier<List<VoiceItem>> {
  VoicesNotifier() : super([]);

  Future<void> fetchVoices(String jwt) async {
    final items = await ApiService.fetchMyVoices(jwt: jwt);
    if (items != null) {
      state = items.map((e) => VoiceItem.fromJson(e)).toList();
    }
  }
}

final voicesProvider = StateNotifierProvider<VoicesNotifier, List<VoiceItem>>(
  (ref) => VoicesNotifier(),
);

final defaultVoiceIdProvider = StateProvider<String?>((ref) => null);
