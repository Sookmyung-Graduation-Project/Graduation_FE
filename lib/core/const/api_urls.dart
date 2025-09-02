class ApiUrls {
  static final String baseUrl = 'http://0.0.0.0:8000';
  // static final String baseUrl = 'http://0.0.0.0:8000'; // simulator
  // static final String baseUrl = '172.30.1.35:8000';

  static final String loginUrl = '$baseUrl/login';
  static final String userInfoUrl = '$baseUrl/me';
  static final String fetchMyVoicesUrl = '$baseUrl/user/myvoice';
  static final String uploadIvcUrl = '$baseUrl/voice/ivc';
  static final String updateDefaultVoiceUrl = '$baseUrl/voice/default';
  static final String renameVoiceUrl = '$baseUrl/voice/name';
  static final String deleteVoiceUrl = '$baseUrl/voice/delete';
  static final String testVoiceUrl = '$baseUrl/voice/tts/test';
}
