class ApiUrls {
  // static final String baseUrl = 'http://172.30.1.40:8000';
  static final String baseUrl = 'http://172.30.1.90:8000';
  static final String loginUrl = '$baseUrl/login';
  static final String userInfoUrl = '$baseUrl/me';

  // Voice
  static final String fetchMyVoicesUrl = '$baseUrl/user/myvoice';
  static final String uploadIvcUrl = '$baseUrl/voice/ivc';
  static final String updateDefaultVoiceUrl = '$baseUrl/voice/default';
  static final String renameVoiceUrl = '$baseUrl/voice/name';
  static final String deleteVoiceUrl = '$baseUrl/voice/delete';
  static final String testVoiceUrl = '$baseUrl/voice/tts/test';
  static final String ttsWithDefaultVoice = '$baseUrl/voice/tts';
  static final String fetchDefaultVoiceUrl = '$baseUrl/voice/default';

  //book
  static final String fetchBookOptions = '$baseUrl/book_generation/options';
  static final String fetchBooksList = '$baseUrl/book_generation/books';
  static final String generateBooks = '$baseUrl/book_generation/generate';
  static String bookDetail(String id) => '$baseUrl/book_generation/books/$id';
}
