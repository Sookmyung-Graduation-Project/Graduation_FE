// somewhere: book_options_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/models/book/book_options.dart';

final bookOptionsProvider = StateProvider<BookOptions?>((ref) => null);
