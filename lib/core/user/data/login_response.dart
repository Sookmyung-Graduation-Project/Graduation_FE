import 'package:phonics/core/user/data/user_state.dart';

class LoginResponse {
  final String accessToken;
  final UserResponse userResponse;

  LoginResponse({
    required this.accessToken,
    required this.userResponse,
  });

  // JSON을 Dart 객체로 변환
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      userResponse:
          UserResponse.fromJson(json['user']), // user key 안에 user 정보가 있다고 가정
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user': userResponse.toJson(),
    };
  }
}
