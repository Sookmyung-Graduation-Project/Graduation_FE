// voice_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/user/data/user_voice.dart';

final voicesProvider = StateProvider<List<VoiceItem>>((ref) => []);
final defaultVoiceIdProvider = StateProvider<String?>((ref) => null);
